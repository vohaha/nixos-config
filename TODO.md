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

## Done

- [x] Config moved into git, split into hosts/modules/home.
- [x] home-manager as a NixOS module; `nh` with automatic GC timer.
- [x] Stale `/etc/nixos` removed.
- [x] Audio: PipeWire (`modules/nixos/audio.nix`) with rtkit + 32-bit ALSA.
- [x] `time.timeZone = "Europe/Kyiv"`.
- [x] Fonts: JetBrainsMono Nerd Font, set as default monospace.
- [x] Desktop tooling (`home/vh/desktop.nix`): waybar, mako, hyprlock,
      hypridle, cliphist, grim/slurp, wl-clipboard, pavucontrol, playerctl,
      brightnessctl.
- [x] Shell (`home/vh/shell.nix`): managed bash, starship, direnv +
      nix-direnv.

## Verify after the next rebuild

Everything below needs a `nh os switch` and a fresh Hyprland session:

- [ ] Sound actually works (`pavucontrol` shows a sink; test playback).
- [ ] Waybar appears and its glyphs render as icons, not boxes.
- [ ] Notifications appear (`notify-send hello`).
- [ ] `hyprlock` locks (test manually **before** trusting the 10-min idle
      timer, so you don't get locked out by a broken lock screen).
- [ ] Clipboard history works (`cliphist list`).
- [ ] Screenshot: `grim -g "$(slurp)" out.png`.
- [ ] Keybinds: nothing above binds any keys. Hyprland's Lua config still
      needs bindings for screenshots, the lock, and the clipboard picker.

## Pending

- [ ] **Hyprland keybinds + wallpaper.** `~/.config/hypr/hyprland.lua` is
      still mutable and unmanaged. Decide whether to bring it under
      home-manager (`xdg.configFile`) or leave it hand-edited. Note Hyprland
      0.56+ uses the Lua format (`hl.monitor({...})`); the older
      `hyprland.conf` is a different, still-supported format.
- [ ] **hyprpaper** deliberately skipped -- it needs an actual wallpaper
      image, and enabling it without one leaves a failing user service.
      Pick an image, then add `services.hyprpaper`.
- [ ] **Push this repo to a remote.** It is the entire definition of this
      machine and exists only on this disk. `hardware-configuration.nix` is
      the painful part to recreate.

## Optional / when needed

- [ ] `hardware.bluetooth.enable`
- [ ] `services.printing.enable`
- [ ] Add `networkmanager` to `users.users.vh.extraGroups` -- only removes
      the polkit prompt when changing network settings. Skipped
      deliberately to keep an earlier refactor behaviour-neutral.
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
