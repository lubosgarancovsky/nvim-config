local cfg = require("config.config")

return {
	-- Themes
	{
		"Aejkatappaja/cendre",
		lazy = false,
		priority = 1000,
		opts = {
			background = "dark",
			transparent = cfg.ui.transparent,
			dim_inactive = false,
			italic_virtual_text = false,
			italic_comments = true,
		},

		config = function(_, opts)
			require("cendre").setup(opts)
			vim.cmd.colorscheme("cendre")
		end,
	},

	{
		"navarasu/onedark.nvim",
		lazy = true,
		opts = {
			style = "warmer",
			transparent = cfg.ui.transparent,
		},

		config = function(_, opts)
			require("onedark").setup(opts)
		end,
	},

	{
		"sainnhe/everforest",
		lazy = true,

		config = function()
			vim.g.everforest_background = "hard"
			vim.g.everforest_transparent_background = cfg.ui.transparent and 1 or 0
		end,
	},

	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		opts = {
			transparent_background = cfg.ui.transparent,
			flavour = "latte",
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
		end,
	},

	{
		"sainnhe/gruvbox-material",
		lazy = true,
		config = function()
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_transparent_background = cfg.ui.transparent and 2 or 0
		end,
	},

	{
		"rockyzhang24/arctic.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		branch = "main",
	},

	{
		"tiagovla/tokyodark.nvim",
		opts = {
			transparent_background = cfg.ui.transparent,
		},
	},

	{
		"doums/darcula",
		lazy = true,
	},

	-- Theme picker
	{
		"zaldih/themery.nvim",
		lazy = false,

		opts = {
			themes = {
				"cendre",
				"gruvbox-material",
				"tokyodark",
				"onedark",
				"everforest",
				"catppuccin",
				"arctic",
				"darcula",
			},

			livePreview = true,
		},

		keys = {
			{
				"<leader>th",
				"<cmd>Themery<CR>",
				desc = "Theme picker",
			},
		},
	},

	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = {
			default = true,
		},
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		opts = {
			pickers = {
				find_files = {
					hidden = true,
				},
			},

			defaults = {
				file_ignore_patterns = {
					"node_modules/",
					"%.git/",
					"dist/",
					"build/",
					"%.next/",
				},
			},
		},

		config = function()
			local telescope = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", telescope.find_files, {
				desc = "Find files",
			})

			vim.keymap.set("n", "<leader>fg", telescope.live_grep, {
				desc = "Live grep",
			})

			vim.keymap.set("n", "<leader>fb", telescope.buffers, {
				desc = "Find buffers",
			})

			vim.keymap.set("n", "<leader>fh", telescope.help_tags, {
				desc = "Find help",
			})

			vim.keymap.set("n", "<leader>fr", telescope.oldfiles, {
				desc = "Find recent",
			})

			vim.keymap.set("n", "<leader>fs", telescope.lsp_document_symbols, {
				desc = "Find symbols",
			})

			vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", {
				desc = "Find TODOs",
			})
		end,
	},

	-- Folders tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},

		keys = {
			{
				"<leader>e",
				"<cmd>Neotree toggle<cr>",
				desc = "File explorer",
			},
		},

		opts = {
			window = {
				width = 45,
				position = "right",
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						"node_modules",
						".next",
						".git",
					},
				},
			},
			close_if_last_window = true,
			default_component_configs = {
				container = { enable_character_fade = true },
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
				},
			},
		},
	},

	-- Keymaps
	{
		"folke/which-key.nvim",
		event = "VeryLazy",

		opts = {
			preset = "helix",
			timeout = 500,

			win = {
				border = "rounded",
				title = " Keymaps ",
				title_pos = "center",
			},

			layout = {
				width = {
					min = 20,
					max = 40,
				},
			},

			spec = {
				{
					"<leader>f",
					group = "Find",
				},
				{
					"<leader>b",
					group = "Buffer",
				},
				{
					"<leader>c",
					group = "Code",
				},
				{
					"<leader>x",
					group = "Diagnostics",
				},
				{
					"<leader>e",
					group = "Explorer",
				},
				{
					"<leader>g",
					group = "Git",
				},
				{
					"<leader>w",
					group = "Windows",
				},
				{
					"<leader>d",
					group = "Debug",
				},
				{
					"<leader>a",
					group = "AI",
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

	-- Notifications
	{
		"folke/noice.nvim",

		event = "VeryLazy",

		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},

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

	{
		"rcarriga/nvim-notify",

		opts = {
			timeout = 3000,
			stages = "fade_in_slide_out",
			render = "default",
			top_down = true,
			background_colour = "Normal",
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

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 20,
			open_mapping = [[<c-\>]],
			direction = "horizontal",
			shade_terminals = false,
		},

		keys = {
			{
				"<leader>tt",
				"<cmd>ToggleTerm<cr>",
				desc = "Toggle terminal",
			},
		},
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
				desc = "Code symbols",
			},

			{
				"<leader>co",
				"<cmd>AerialNavToggle<CR>",
				desc = "Code symbols navigation",
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

	-- Snacks
	{
		"folke/snacks.nvim",
		opts = {
			indent = {
				enabled = true,
			},
			dashboard = {
				enabled = true,
			},
		},
	},
}
