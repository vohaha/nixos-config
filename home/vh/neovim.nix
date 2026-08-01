# Neovim, set up for LazyVim.
#
# Split of responsibilities: Nix provides every binary (neovim, language
# servers, formatters, debuggers), while the Lua config stays mutable in
# ~/.config/nvim so plugins and keymaps can be iterated on without a rebuild.
#
# Mason is disabled in the Lua config on purpose: it downloads pre-built,
# dynamically-linked binaries that assume an FHS layout and are unreliable on
# NixOS. Everything Mason would fetch is listed below instead.
{ pkgs, ... }:

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
}
