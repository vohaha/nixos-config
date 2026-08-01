-- LSP via the 0.12 built-ins: vim.lsp.config() + vim.lsp.enable().
-- No nvim-lspconfig. Every `cmd` below is provided by Nix (home/vh/neovim.nix),
-- so these binaries are always on PATH.

vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  severity_sort = true,
  float = { border = "rounded", source = true },
})

local servers = {
  nixd = {
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", ".git" },
    -- Points nixd at this flake's evaluated option trees, so `K` (hover) and
    -- goto-definition on option fields (e.g. `initLua` in neovim.nix) show
    -- their docs/declarations instead of resolving to nothing.
    settings = {
      nixd = {
        options = {
          nixos = {
            expr = '(builtins.getFlake (toString ./.)).nixosConfigurations.nixosDesktop.options',
          },
          ["home-manager"] = {
            expr =
            '(builtins.getFlake (toString ./.)).nixosConfigurations.nixosDesktop.options.home-manager.users.type.getSubOptions []',
          },
        },
      },
    },
  },

  vtsls = {
    cmd = { "vtsls", "--stdio" },
    filetypes = {
      "javascript", "javascriptreact", "typescript", "typescriptreact",
    },
    root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
  },

  jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { ".git" },
  },

  html = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_markers = { "package.json", ".git" },
  },

  cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
  },

  eslint = {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = {
      "javascript", "javascriptreact", "typescript", "typescriptreact",
    },
    root_markers = {
      "eslint.config.js", "eslint.config.mjs", ".eslintrc.json", ".eslintrc.js", ".git",
    },
  },

  basedpyright = {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
  },

  -- Fast linting/formatting alongside basedpyright's type checking.
  ruff = {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".git" },
  },

  rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-project.json", ".git" },
  },

  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
  },

  jdtls = {
    cmd = { "jdtls" },
    filetypes = { "java" },
    root_markers = { "pom.xml", "build.gradle", "build.gradle.kts", ".git" },
  },

  omnisharp = {
    cmd = { "OmniSharp", "-lsp" },
    filetypes = { "cs" },
    root_markers = { "*.sln", "*.csproj", ".git" },
  },

  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".stylua.toml", ".git", "init.lua" },
    settings = {
      Lua = {
        -- Stop it complaining about `vim` when editing this config.
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  },
}

for name, cfg in pairs(servers) do
  vim.lsp.config(name, cfg)
end

vim.lsp.enable(vim.tbl_keys(servers))

-- Buffer-local keymaps, set only where a server actually attached.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
    end

    map("grd", vim.lsp.buf.definition, "goto definition")
    map("grD", vim.lsp.buf.declaration, "goto declaration")
    map("gri", vim.lsp.buf.implementation, "goto implementation")
    map("grr", vim.lsp.buf.references, "references")
    map("grn", vim.lsp.buf.rename, "rename")
    map("gra", vim.lsp.buf.code_action, "code action")
    map("K", vim.lsp.buf.hover, "hover docs")
    map("<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "format buffer")
  end,
})
