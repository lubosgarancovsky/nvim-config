vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("yank_highlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restore cursor position",
	group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line_count = vim.api.nvim_buf_line_count(0)

		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Close temporary windows with q",
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		"help",
		"qf",
		"man",
		"lspinfo",
		"checkhealth",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false

		vim.keymap.set("n", "q", "<cmd>close<cr>", {
			buffer = event.buf,
			silent = true,
		})
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	desc = "Check for external file changes",
	group = vim.api.nvim_create_augroup("checktime", { clear = true }),
	callback = function()
		vim.cmd("checktime")
	end,
})
