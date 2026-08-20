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
		"tiagovla/tokyodark.nvim",
		opts = {
			transparent_background = cfg.ui.transparent,
		},
	},

	{
		"miladggg/neonwave.nvim",
		lazy = true,
		config = function()
			require("neonwave").setup({
				intensity = "neon", -- 'soft' or 'neon'
				background = "auto", -- 'light' or 'dark' to lock; 'auto' follows 'background'
				transparent_background = cfg.ui.transparent,
			})
		end,
	},

	{
		"rose-pine/neovim",
		lazy = true,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = cfg.ui.transparent,
				},
			})
		end,
	},

	{
		"scottmckendry/cyberdream.nvim",
		lazy = true,
		opts = {
			transparent = cfg.ui.transparent,
		},
	},

	-- Theme picker
	{
		"zaldih/themery.nvim",
		lazy = false,

		opts = {
			themes = {
				"cendre",
				"tokyodark",
				"onedark",
				"everforest",
				"neonwave",
				"rose-pine",
				"cyberdream",
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
