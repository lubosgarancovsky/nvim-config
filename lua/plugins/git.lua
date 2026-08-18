return {
	{
		"lewis6991/gitsigns.nvim",

		event = { "BufReadPre", "BufNewFile" },

		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		},

		keys = {
			{
				"]h",
				function()
					require("gitsigns").next_hunk()
				end,
				desc = "Next Git hunk",
			},

			{
				"[h",
				function()
					require("gitsigns").prev_hunk()
				end,
				desc = "Previous Git hunk",
			},

			{
				"<leader>gs",
				function()
					require("gitsigns").stage_hunk()
				end,
				desc = "Stage hunk",
			},

			{
				"<leader>gr",
				function()
					require("gitsigns").reset_hunk()
				end,
				desc = "Reset hunk",
			},

			{
				"<leader>gp",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "Preview hunk",
			},

			{
				"<leader>gb",
				function()
					require("gitsigns").blame_line()
				end,
				desc = "Blame line",
			},

			{
				"<leader>gS",
				function()
					require("gitsigns").stage_buffer()
				end,
				desc = "Stage buffer",
			},

			{
				"<leader>gR",
				function()
					require("gitsigns").reset_buffer()
				end,
				desc = "Reset buffer",
			},
		},
	},

	{
		"sindrets/diffview.nvim",

		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewFileHistory",
		},

		keys = {
			{
				"<leader>gd",
				"<cmd>DiffviewOpen<cr>",
				desc = "Git diff",
			},

			{
				"<leader>gD",
				"<cmd>DiffviewClose<cr>",
				desc = "Close diff",
			},

			{
				"<leader>gh",
				"<cmd>DiffviewFileHistory %<cr>",
				desc = "File history",
			},

			{
				"<leader>gH",
				"<cmd>DiffviewFileHistory<cr>",
				desc = "Git history",
			},
		},

		opts = {},
	},
}
