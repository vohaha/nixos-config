{ ... }:

{
  # Settings are left mutable so Zed's own UI can still write
  # ~/.config/zed/settings.json. Move them here via `userSettings` once
  # they stabilise.
  programs.zed-editor.enable = true;

  # Upstream names the binary `zeditor`; `zed` is an unrelated package.
  home.shellAliases.zed = "zeditor";
}
