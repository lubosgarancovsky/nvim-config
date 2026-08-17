return {
	{
		"saghen/blink.cmp",

		dependencies = {
			"L3MON4D3/LuaSnip",
			"saghen/blink.lib",
		},

		opts = {
			snippets = {
				preset = "luasnip",
			},

			keymap = {
				preset = "super-tab",
			},

			completion = {
				ghost_text = {
					enabled = true,
				},
			},

			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"minuet",
				},
				providers = {
					minuet = {
						name = "minuet",
						module = "minuet.blink",
						async = true,
						timeout_ms = 3000,
						score_offset = 50,
					},
				},
			},

			-- For rust fuzzy a build method must be added and cargo must be installed on the system
			-- :h blink-cmp-installation
			fuzzy = {
				implementation = "lua",
			},
		},
	},

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},

		opts = {},

		config = function(_, opts)
			require("luasnip").setup(opts)
			require("snippets")
		end,
	},
}
