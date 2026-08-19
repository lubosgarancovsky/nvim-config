return {
	-- Code formatter
	{
		"stevearc/conform.nvim",

		opts = {
			formatters_by_ft = {
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },

				json = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },

				lua = { "stylua" },

				c = { "clang_format" },
				cpp = { "clang_format" },

				python = { "ruff_format" },
			},
		},

		config = function(_, opts)
			local conform = require("conform")

			conform.setup(opts)

			-- Manual formatting
			vim.keymap.set("n", "<leader>cf", function()
				conform.format({
					async = true,
					lsp_fallback = true,
				})
			end, {
				desc = "Format buffer",
			})

			-- Format before saving
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					conform.format({
						bufnr = args.buf,
						timeout_ms = 1000,
						lsp_fallback = true,
					})
				end,
			})
		end,
	},

	-- Automatic code actions
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",

		config = function()
			local npairs = require("nvim-autopairs")

			npairs.setup({
				check_ts = true,

				ts_config = {
					lua = { "string" },
					javascript = { "string" },
					javascriptreact = { "string" },
					typescript = { "string" },
					typescriptreact = { "string" },
				},
			})
		end,
	},

	-- Warnings / Errors
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer diagnostics",
			},
		},
	},

	-- Comments
	{
		"echasnovski/mini.comment",
		version = "*",

		opts = {},
	},

	-- to-do comments
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {},
	},

	-- Colored brackets
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},

		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					commonlisp = rainbow_delimiters.strategy["local"],
				},

				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},

				priority = {
					[""] = 110,
					lua = 210,
				},

				highlight = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
				},
			}
		end,
	},

	-- Auto tag for html
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},

		opts = {},
	},

	-- Folds
	{
		"kevinhwang91/nvim-ufo",

		dependencies = {
			"kevinhwang91/promise-async",
		},

		config = function()
			-- Folding settings
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})

			-- Open/close all folds
			vim.keymap.set("n", "zR", require("ufo").openAllFolds, {
				desc = "Open all folds",
			})

			vim.keymap.set("n", "zM", require("ufo").closeAllFolds, {
				desc = "Close all folds",
			})

			-- Open folds except certain kinds
			vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, {
				desc = "Open folds except kinds",
			})

			-- Close folds with a certain level
			vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, {
				desc = "Close folds with level",
			})
		end,
	},

	{
		"catgoose/nvim-colorizer.lua",
		opts = {
			filetypes = {
				"typescript",
				"typescriptreact",
				"javascript",
				"javascriptreact",
				"css",
				"scss",
				"html",
			},
			user_default_options = {
				mode = "background",
				RRGGBB = true,
				RRGGBBAA = true,
				names = false,
				RGB = true,
				css = true,
			},
		},
		keys = {
			{
				"<leader>uc",
				"<cmd>ColorizerToggle<cr>",
				desc = "Toggle Colorizer",
			},
		},
	},
}
