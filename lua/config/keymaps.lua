vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", {
	desc = "Split vertically",
})

vim.keymap.set("n", "<leader>wh", "<cmd>split<cr>", {
	desc = "Split horizontally",
})

vim.keymap.set("n", "<leader>wd", "<cmd>close<cr>", {
	desc = "Close window",
})

vim.keymap.set("n", "<leader>wo", "<cmd>only<cr>", {
	desc = "Close window",
})

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right" })

-- Buffers
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCyclePrev<cr>", {
	desc = "Previous buffer",
})

vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCycleNext<cr>", {
	desc = "Next buffer",
})

vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", {
	desc = "Previous buffer",
})

vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", {
	desc = "Next buffer",
})

vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", {
	desc = "Previous buffer",
})

vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", {
	desc = "Next buffer",
})

vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", {
	desc = "Delete buffer",
})

vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", {
	desc = "Delete other buffers",
})
-- Diagnosticss
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, {
	desc = "Line diagnostics",
})

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
	desc = "Next diagnostic",
})

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
	desc = "Previous diagnostic",
})

-- Other
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", {
	desc = "Clear search highlight",
})
