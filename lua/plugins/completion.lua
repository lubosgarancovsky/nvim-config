local cfg = require("config.settings").load()

local default_sources = {
	"lsp",
	"path",
	"snippets",
	"buffer",
}

local providers = {}

if cfg.ai.enabled then
	table.insert(default_sources, "minuet")

	providers.minuet = {
		name = "minuet",
		module = "minuet.blink",
		async = true,
		timeout_ms = 3000,
		score_offset = 50,
	}
end

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
				default = default_sources,
				providers = providers,
			},

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
