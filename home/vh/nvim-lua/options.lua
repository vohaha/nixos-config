local o = vim.o

o.number = true
o.relativenumber = true
o.signcolumn = "yes" -- stop the gutter jumping when diagnostics appear
o.cursorline = true
o.wrap = false
o.scrolloff = 8

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

o.ignorecase = true
o.smartcase = true -- case-sensitive only when the search has capitals
o.inccommand = "split" -- live preview of :s

o.splitright = true
o.splitbelow = true

o.undofile = true -- persistent undo across restarts
o.swapfile = false
o.updatetime = 250
o.timeoutlen = 400

o.termguicolors = true
o.confirm = true -- prompt instead of failing on unsaved quit

-- Use ripgrep (installed via Nix) for :grep
if vim.fn.executable("rg") == 1 then
  o.grepprg = "rg --vimgrep --smart-case"
  o.grepformat = "%f:%l:%c:%m"
end

-- Briefly highlight yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})
