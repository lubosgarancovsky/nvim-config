return {
	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = {
			default = true,
		},
	},

	-- Noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			messages = {
				enabled = true,
			},

			notify = {
				enabled = true,
			},

			lsp = {
				progress = {
					enabled = true,
				},

				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},

			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},

			views = {
				notify = {
					backend = "notify",
					fallback = "mini",
				},
			},
		},
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		opts = {},
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = "",
				section_separators = "",
			},

			sections = {
				lualine_a = {
					"mode",
				},

				lualine_b = {
					"branch",
					"diff",
				},

				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},

				lualine_x = {
					{
						function()
							local msg = "No Active Lsp"
							local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if next(clients) == nil then
								return msg
							end
							for _, client in ipairs(clients) do
								local filetypes = client.config.filetypes
								if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
									return client.name
								end
							end
							return msg
						end,
						icon = " LSP:",
						color = { fg = "#ffffff", gui = "bold" },
					},
					"diagnostics",
					"filetype",
				},

				lualine_y = {
					"encoding",
					"fileformat",
				},

				lualine_z = {
					"location",
				},
			},
		},
	},

	-- Keeps current scope at the top of a screen
	{
		"nvim-treesitter/nvim-treesitter-context",

		event = "VeryLazy",

		opts = {
			enable = true,
			max_lines = 4,
			min_window_height = 20,
			line_numbers = true,
			multiline_threshold = 1,
			trim_scope = "outer",
			mode = "cursor",
			separator = "─",
		},
	},

	-- Search & replace
	{
		"MagicDuck/grug-far.nvim",

		cmd = "GrugFar",

		keys = {
			{
				"<leader>sr",
				"<cmd>GrugFar<cr>",
				desc = "Search & replace",
			},
		},

		opts = {},
	},

	-- Markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-mini/mini.nvim",
		},
		opts = {},
	},

	-- Aerial
	{
		"stevearc/aerial.nvim",

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			backends = {
				"lsp",
				"treesitter",
				"markdown",
				"man",
			},

			layout = {
				default_direction = "left",
				min_width = 30,
			},

			show_guides = true,

			filter_kind = false,
		},

		keys = {
			{
				"<leader>cs",
				"<cmd>AerialToggle!<CR>",
				desc = "Symbols",
			},
		},
	},

	-- Task runner
	{
		"stevearc/overseer.nvim",

		opts = {
			strategy = "toggleterm",

			task_list = {
				direction = "bottom",
				min_height = 10,
				max_height = 15,
				default_detail = 1,
			},

			component_aliases = {
				default = {
					"display_duration",
					"on_output_summarize",
					"on_exit_set_status",
					"on_complete_notify",
				},

				default_vscode = {
					"default",
				},
			},
		},

		keys = {
			{
				"<leader>tl",
				"<cmd>OverseerToggle<CR>",
				desc = "Task list",
			},

			{
				"<leader>tr",
				"<cmd>OverseerRun<CR>",
				desc = "Run task",
			},

			{
				"<leader>ta",
				"<cmd>OverseerQuickAction<CR>",
				desc = "Task action",
			},

			{
				"<leader>ts",
				"<cmd>OverseerTaskAction<CR>",
				desc = "Task action",
			},
		},
	},

	-- Movement
	{
		"echasnovski/mini.move",
		version = false,
		opts = {
			mappings = {
				left = "<M-h>",
				right = "<M-l>",
				down = "<M-j>",
				up = "<M-k>",
				line_left = "<M-h>",
				line_right = "<M-l>",
				line_down = "<M-j>",
				line_up = "<M-k>",
			},
		},
	},

	-- Vim motion improvements
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
			-- Simulate nvim-treesitter incremental selection
			{
				"<c-space>",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter({
						actions = {
							["<c-space>"] = "next",
							["<BS>"] = "prev",
						},
					})
				end,
				desc = "Treesitter Incremental Selection",
			},
		},
	},

	-- Persistent session
	{
		"folke/persistence.nvim",
		event = "BufReadPre",

		opts = {
			dir = vim.fn.stdpath("state") .. "/sessions/",
			need = 1,
			branch = true,
		},
	},
}
