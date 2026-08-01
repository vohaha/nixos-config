-- Plugins via the built-in vim.pack (no plugin manager needed on 0.12+).
-- Versions are pinned in the lockfile; update with :lua vim.pack.update()

vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  -- Supplies the textobject queries mini.ai uses below.
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  { src = "https://github.com/folke/tokyonight.nvim" },
})

vim.cmd.colorscheme("tokyonight")

-- ---------------------------------------------------------------------------
-- Treesitter (nvim-treesitter `main` branch).
--
-- The `main` branch has no configs.setup{highlight=...} -- that is the old
-- `master` API most guides still show. Here parsers are installed explicitly
-- and highlighting is started per-buffer.
--
-- Parsers compile with `cc`, provided by Nix (home/vh/neovim.nix).
-- Add a language: put it in this list, restart, or run :TSInstall <lang>.
-- ---------------------------------------------------------------------------

local parsers = {
  "bash", "c", "c_sharp", "css", "diff", "dockerfile", "git_config",
  "gitcommit", "gitignore", "go", "gomod", "gosum", "html", "java",
  "javascript", "json", "lua", "luadoc", "make", "markdown",
  "markdown_inline", "nix", "python", "query", "regex", "rust", "sql",
  "toml", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml",
}

do
  local nts = require("nvim-treesitter")
  local installed = {}
  for _, p in ipairs(nts.get_installed()) do
    installed[p] = true
  end

  local missing = {}
  for _, p in ipairs(parsers) do
    if not installed[p] then
      missing[#missing + 1] = p
    end
  end

  -- Async; only runs when something is actually absent, so startup stays fast.
  if #missing > 0 then
    nts.install(missing)
  end
end

-- Start highlighting + treesitter indentation wherever a parser exists.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang then
      return
    end
    -- language.add() returns false when no parser is installed for it.
    if pcall(vim.treesitter.language.add, lang) then
      pcall(vim.treesitter.start, ev.buf, lang)
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- ---------------------------------------------------------------------------
-- mini.nvim modules. Each is independent; add or drop freely.
-- ---------------------------------------------------------------------------

-- Editing
-- Text objects. The treesitter-backed ones are the main reason to run
-- treesitter at all: vaf = "select this function", dic = "delete class body".
local ai_ts = require("mini.ai").gen_spec.treesitter
require("mini.ai").setup({
  custom_textobjects = {
    f = ai_ts({ a = "@function.outer", i = "@function.inner" }),
    c = ai_ts({ a = "@class.outer", i = "@class.inner" }),
    o = ai_ts({ -- blocks/conditionals/loops
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
  },
})
require("mini.surround").setup() -- sa/sd/sr to add/delete/replace surroundings
require("mini.pairs").setup() -- auto-close brackets
require("mini.comment").setup() -- gc / gcc
require("mini.move").setup() -- alt+hjkl to move lines/selections

-- UI
require("mini.statusline").setup()
require("mini.icons").setup()
require("mini.notify").setup()
require("mini.hipatterns").setup() -- highlight TODO/FIXME, hex colours
require("mini.indentscope").setup({ symbol = "│" })

-- Navigation
require("mini.pick").setup() -- picker: files, grep, buffers, help
require("mini.files").setup() -- file explorer as an editable buffer
require("mini.bracketed").setup() -- ]b ]q ]d ... jump between things

-- Git
require("mini.diff").setup() -- inline diff signs
require("mini.git").setup()

-- Completion (LSP-aware, no nvim-cmp/blink needed)
require("mini.completion").setup()

-- Session-ish niceties
require("mini.trailspace").setup() -- highlight trailing whitespace
