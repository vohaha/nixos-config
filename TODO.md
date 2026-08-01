# TODO

Working notes for this config. Last updated 2026-08-01.

## Where things stand

Migration is done and applied: the config lives in this repo, home-manager
runs as a NixOS module, and `nh` is in use. Rebuild with:

```
nh os switch          # no sudo, no path -- $NH_FLAKE points here
```

Layout: `hosts/` = machine-specific, `modules/nixos/` = reusable system
config, `home/vh/` = per-user.

## Verify after the next rebuild

## Pending

- [ ] **Hyprland keybinds + wallpaper.** `~/.config/hypr/hyprland.lua` is
      still mutable and unmanaged. Decide whether to bring it under
      home-manager (`xdg.configFile`) or leave it hand-edited. Note Hyprland
      0.56+ uses the Lua format (`hl.monitor({...})`); the older
      `hyprland.conf` is a different, still-supported format.
- [ ] **hyprpaper** deliberately skipped -- it needs an actual wallpaper
      image, and enabling it without one leaves a failing user service.
      Pick an image, then add `services.hyprpaper`.
- [ ] **SSH key management.** Nothing is set up yet -- no keys in `~/.ssh`,
      no agent, no known_hosts policy. Needed before pushing this repo
      anywhere. Decide, in this order:
      - Generate a key (`ssh-keygen -t ed25519 -C "dev@volodymyrkondratenko.com"`).
        Keys themselves are **secrets: never commit them**, and never put a
        private key in a nix file -- everything in the store is world-readable.
      - Agent: `services.ssh-agent` (home-manager) or gnome-keyring. With
        `AddKeysToAgent yes` so the passphrase is asked once per session.
      - Declarative client config via `programs.ssh` in home-manager
        (`matchBlocks` for hosts, `identityFile`, `identitiesOnly`). This part
        *is* safe to commit -- it holds no secrets.
      - If secrets ever do need to live in this repo, use sops-nix or
        agenix rather than plain files.
      - Optional: hardware-backed keys, or `services.openssh` host-key
        hardening for inbound ssh (the daemon is already enabled).

- [ ] **Push this repo to a remote.** It is the entire definition of this
      machine and exists only on this disk. `hardware-configuration.nix` is
      the painful part to recreate. Blocked on SSH keys above (or use a
      HTTPS remote with a token).

## Optional / when needed

- [ ] `hardware.bluetooth.enable`
- [ ] `services.printing.enable`
- [ ] Add `networkmanager` to `users.users.vh.extraGroups` -- only removes
      the polkit prompt when changing network settings. Skipped
      deliberately to keep an earlier refactor behaviour-neutral.
- [ ] **neovim:** treesitter parsers are not installed. `:TSInstall nix go
      rust python typescript` for the languages you want. Only `c, lua,
      markdown, query, vim, vimdoc` ship with neovim. Dropping
      nvim-treesitter entirely is a legitimate choice -- it buys accurate
      highlighting and structural text objects (mini.ai uses it), nothing
      semantic. LSP covers meaning; treesitter covers shape.
- [ ] **neovim:** no format-on-save. Formatters are installed and
      `<leader>cf` formats manually; add conform.nvim or a BufWritePre
      autocmd if automatic is wanted.
- [ ] **neovim:** `~/.config/nvim` is unmanaged and outside git. Either
      track it in this repo or give it its own.
- [ ] Move Zed settings into `programs.zed-editor.userSettings` once they
      stabilise. Note: doing so makes `~/.config/zed/settings.json` a
      read-only store symlink and Zed's in-app settings UI stops working
      unless `mutableUserSettings` is set.
- [ ] `services.pipewire.jack.enable` for pro-audio clients.

## Gotchas worth remembering

- Nix only sees **git-tracked** files. A new `.nix` file that is not
  `git add`-ed fails with a confusing "file not found".
- `git config --global ...` fails now -- `~/.config/git/config` is a store
  symlink. Edit `home/vh/git.nix` and rebuild instead.
- The Zed binary is `zeditor`, not `zed` (aliased in `home/vh/zed.nix`).
- Shell aliases only appear in **new** shells after a rebuild.
- `nh os switch` runs without `sudo`; it escalates on its own.
- GC is automatic via the `nh-clean.timer` (keeps 5 generations / 7 days).
- Don't configure tools from memory -- see AGENTS.md. Hyprland's Lua config
  and home-manager's `programs.git.settings` rename both caught me out.
