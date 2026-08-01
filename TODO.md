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

## Pending -- finish these first

- [ ] **Remove the stale `/etc/nixos`.** Verified byte-identical to commit
      `a1eb002`, so nothing is lost. Blocked on a permission prompt, run
      manually:
      ```
      sudo rm /etc/nixos/{configuration,flake,hardware-configuration}.nix \
              /etc/nixos/flake.lock && sudo rmdir /etc/nixos
      ```
      Removing the dir makes a bare `nixos-rebuild` (no `--flake`) fail
      loudly instead of building a stale config.

- [ ] **Audio does not work.** Neither pipewire nor pulseaudio is enabled.
      Add `modules/nixos/audio.nix`:
      ```nix
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      ```

- [ ] **Set `time.timeZone`.** Currently unset, so the system is on UTC.

## Desktop -- Hyprland is a bare compositor right now

None of the usual supporting pieces are installed. Prefer home-manager
modules over bare packages where they exist (real config options):

- [ ] Notifications: `mako`
- [ ] Bar: `waybar`
- [ ] Screenshots: `grim` + `slurp`
- [ ] Clipboard: `wl-clipboard` + `cliphist`
- [ ] Lock / idle: `hyprlock` + `hypridle`
- [ ] Wallpaper: `hyprpaper`
- [ ] Audio GUI + media keys: `pavucontrol`, `playerctl`
- [ ] A Nerd Font -- the current font set has no monospace/icon font, so
      Waybar and terminal glyphs will render as boxes.

- [ ] **Figure out `~/.config/hypr/hyprland.lua`.** Hyprland reads
      `hyprland.conf`; a `.lua` file is not a filename it loads. Leftover,
      or from some wrapper? Resolve before writing Hyprland config, then
      decide whether to manage it declaratively via home-manager.

## Developer environment

- [ ] **`direnv` + `nix-direnv`** -- biggest quality-of-life win. Per-project
      toolchains on `cd`, with caching so dev shells survive GC.
- [ ] **Shell config.** Currently plain bash with nothing managed. Either
      `programs.bash` in home-manager, or switch to zsh/fish, to get
      prompt/history/completion under version control.

## Safety

- [ ] **Push this repo to a remote.** It is the entire definition of this
      machine and exists only on this disk. `hardware-configuration.nix` is
      the painful part to recreate.

## Optional / when needed

- [ ] `hardware.bluetooth.enable`
- [ ] `services.printing.enable`
- [ ] Add `networkmanager` to `users.users.vh.extraGroups` -- only removes
      the polkit prompt when changing network settings. Skipped
      deliberately to keep the refactor behaviour-neutral.
- [ ] Move Zed settings into `programs.zed-editor.userSettings` once they
      stabilise. Note: doing so makes `~/.config/zed/settings.json` a
      read-only store symlink and Zed's in-app settings UI stops working
      unless `mutableUserSettings` is set.

## Gotchas worth remembering

- Nix only sees **git-tracked** files. A new `.nix` file that is not
  `git add`-ed fails with a confusing "file not found".
- `git config --global ...` fails now -- `~/.config/git/config` is a store
  symlink. Edit `home/vh/git.nix` and rebuild instead.
- The Zed binary is `zeditor`, not `zed` (aliased in `home/vh/zed.nix`).
- Shell aliases only appear in **new** shells after a rebuild.
- `nh os switch` runs without `sudo`; it escalates on its own.
- GC is automatic via the `nh-clean.timer` (keeps 5 generations / 7 days).
