return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",

		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup()

			local parsers = {
				"bash",
				"c",
				"cpp",
				"css",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"sql",
				"tsx",
				"typescript",
				"yaml",
			}

			treesitter.install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
				callback = function(event)
					local lang = vim.treesitter.language.get_lang(event.match)
					if vim.tbl_contains(parsers, lang) then
						-- Parsers may still be installing on the first launch.
						pcall(vim.treesitter.start, event.buf)
					end
				end,
			})
		end,
	},
}
