You help me to manage this repo for the nixos-config. I can request changes to the config and you should find a canonical way for this. Tell me explicitly if the changes I requested agains canonical way or community best practices.

## Verify tool knowledge before configuring

Do not configure a tool from memory. The tools here (Hyprland, home-manager,
nixpkgs, nh, waybar, Zed, ...) move fast, and training data goes stale — options
get renamed, new config formats land, and defaults change between releases.

Before writing or changing config for a tool:

1. **Check what this repo actually pins.** The flake follows `nixos-unstable`
   and home-manager `master`, so options can differ from any tutorial. Inspect
   the real module rather than guessing:
   ```
   nix eval .#nixosConfigurations.nixosDesktop.config.<option>
   nix flake check --no-build     # surfaces renamed/deprecated options
   ```
   Grep the home-manager source for the module and read its option definitions.

2. **Check the installed version**, not the latest release: `hyprctl version`,
   `nh --version`, `<tool> --version`.

3. **Consult current upstream docs** (web) when the local source is not
   conclusive, especially for config-file formats which live outside Nix.

4. **Treat evaluation warnings as authoritative.** A deprecation warning from
   `nix flake check` beats anything remembered.

Known examples of exactly this going wrong:

- Hyprland 0.56+ supports a **Lua** config (`~/.config/hypr/hyprland.lua`,
  `hl.monitor({...})`), alongside the older `hyprland.conf`. Assuming `.conf`
  is the only format is wrong.
- home-manager renamed `programs.git.userName` / `userEmail` / `extraConfig`
  to `programs.git.settings.*`.
- The Zed binary is `zeditor`, not `zed`.

## Repo conventions

- Layout: `hosts/` = machine-specific, `modules/nixos/` = reusable system
  config, `home/vh/` = per-user (home-manager).
- Nix only sees **git-tracked** files — `git add` new `.nix` files or
  evaluation fails with a confusing "file not found".
- Verify changes with `nix flake check --no-build` before claiming they work.
  For refactors, diff the system derivation to prove nothing changed.
- Rebuild with `nh os switch` (no sudo, no path).
- Keep `TODO.md` current when finishing or discovering work.
