local cfg = require("config.settings").load()

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
				"<leader>ut",
				"<cmd>Themery<CR>",
				desc = "Theme picker",
			},
		},
	},
}
