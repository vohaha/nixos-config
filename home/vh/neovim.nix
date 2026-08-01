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

    withNodeJs = true; # required by several LazyVim plugins
    withPython3 = true;

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
