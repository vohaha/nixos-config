local map = vim.keymap.set

-- Pickers (mini.pick)
map("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "find files" })
map("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "grep" })
map("n", "<leader>fb", "<cmd>Pick buffers<cr>", { desc = "buffers" })
map("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "help tags" })
map("n", "<leader>fd", "<cmd>Pick diagnostic<cr>", { desc = "diagnostics" })

-- File explorer (mini.files)
map("n", "<leader>e", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
end, { desc = "file explorer" })

-- Buffers
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "delete buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "next buffer" })

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- Keep the cursor centred when jumping through search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Move the selection without clobbering the register on paste
map("x", "p", [["_dP]])

-- Diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "line diagnostics" })
