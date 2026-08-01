# Neovim, set up for LazyVim.
#
# Split of responsibilities: Nix provides every binary (neovim, language
# servers, formatters, debuggers), while the Lua config stays mutable so
# plugins and keymaps can be iterated on without a rebuild. The Lua files
# live in this repo (./nvim-lua) for version control, and are symlinked into
# ~/.config/nvim/lua by the activation script below -- editing them edits the
# repo directly, no rebuild needed to pick up changes.
#
# Mason is disabled in the Lua config on purpose: it downloads pre-built,
# dynamically-linked binaries that assume an FHS layout and are unreliable on
# NixOS. Everything Mason would fetch is listed below instead.
{ pkgs, lib, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withPython3 = true;

    # home-manager always generates ~/.config/nvim/init.lua when this module
    # has anything to configure (provider paths, below), so it cannot stay a
    # hand-written file. Keep the generated init.lua minimal and have it pull
    # in ~/.config/nvim/lua/*.lua, which home-manager does NOT manage -- those
    # stay mutable and editable without a rebuild.
    initLua = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"

      require("options")
      require("plugins")
      require("lsp")
      require("keymaps")
    '';

    extraPackages = with pkgs; [
      # --- LazyVim prerequisites ---
      ripgrep # telescope/grep picker
      fd # file picker
      lazygit # LazyVim's git UI (<leader>gg)
      tree-sitter # :TSInstall parser compilation
      gcc # compiler for tree-sitter parsers

      # --- Nix ---
      nixd
      nixfmt

      # --- TypeScript / JavaScript / web ---
      vtsls # LazyVim's default TS server
      vscode-langservers-extracted # json, html, css, eslint
      prettier

      # --- Python ---
      basedpyright
      ruff

      # --- Rust ---
      rust-analyzer

      # --- Go ---
      gopls
      gotools # goimports
      delve # debugger

      # --- Java ---
      jdt-language-server

      # --- C# / .NET ---
      omnisharp-roslyn

      # --- Lua (for editing the neovim config itself) ---
      lua-language-server
      stylua
    ];
  };

  # Symlink the repo's Lua files into place instead of copying them via
  # home.file. Deliberately NOT `${./nvim-lua}` -- that would resolve to a
  # read-only copy in /nix/store, defeating the point. This points straight
  # at the git checkout so editing the files edits the working tree (no
  # rebuild to pick up changes, and `git status` here shows what changed).
  home.activation.linkNvimLua = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run rm -rf "${config.home.homeDirectory}/.config/nvim/lua"
    run ln -sfn "${config.home.homeDirectory}/nixos-config/home/vh/nvim-lua" "${config.home.homeDirectory}/.config/nvim/lua"
  '';
}
