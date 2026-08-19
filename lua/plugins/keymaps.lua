return {
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
					group = "Database",
				},
				{
					"<leader>a",
					group = "AI",
				},
				{
					"<leader>u",
					group = "UI",
				},
				{
					"<leader>t",
					group = "Task",
				},
			},
		},
	},
}
