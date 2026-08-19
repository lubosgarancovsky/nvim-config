return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			animate = {
				enabled = true,
			},
			bigfile = {
				enabled = true,
			},
			bufdelete = {
				enabled = true,
			},
			explorer = {
				enabled = true,
			},
			gh = {
				enabled = true,
			},
			git = {
				enabled = true,
			},
			gitbrowse = {
				enabled = true,
			},
			indent = {
				enabled = true,
			},
			input = {
				enabled = true,
			},
			lazygit = {
				enabled = true,
			},
			notifier = {
				enabled = true,
			},
			notify = {
				enabled = true,
			},
			picker = {
				enabled = true,
				sources = {
					explorer = {
						layout = {
							layout = {
								position = "right",
								width = 45,
							},
						},
						exclude = {
							".git",
							"node_modules",
							"dist",
							"build",
						},

						include = {
							".env",
							".env.*",
							"*local*",
						},
					},
				},
			},
			scroll = {
				enabled = true,
			},
			statuscolumn = {
				enabled = true,
			},
			terminal = {
				enabled = true,
			},

			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" },
					{
						pane = 2,
						section = "terminal",
						cmd = "colorscript -e square",
						height = 5,
						padding = 1,
					},
					{ section = "keys", gap = 1, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{
						pane = 2,
						icon = " ",
						desc = "Browse Repo",
						padding = 1,
						key = "b",
						action = function()
							Snacks.gitbrowse()
						end,
					},
					function()
						local in_git = Snacks.git.get_root() ~= nil
						local cmds = {
							{
								icon = " ",
								title = "Git Status",
								cmd = "git --no-pager diff --stat -B -M -C",
								height = 6,
							},
						}
						return vim.tbl_map(function(cmd)
							return vim.tbl_extend("force", {
								pane = 2,
								section = "terminal",
								enabled = in_git,
								padding = 1,
								ttl = 5 * 60,
								indent = 3,
							}, cmd)
						end, cmds)
					end,
					{
						pane = 2,
						section = "terminal",
						icon = "󰄬 ",
						title = "TODOs",
						cmd = "rg --no-heading --line-number 'TODO|FIXME|HACK|XXX' -g '!node_modules' -g '!.git' | head -8",
						height = 6,
						padding = 1,
						ttl = 5 * 60,
					},
					{
						pane = 2,
						section = "terminal",
						icon = "󰜘 ",
						title = "Recent Commits",
						cmd = "git log --oneline -8",
						height = 6,
						padding = 1,
						ttl = 5 * 60,
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
					},
					{ section = "startup" },
				},
				preset = {
					header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣀⡤⠖⠛⠋⠉⠉⠀⠉⠁⠲⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣠⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⣀⣼⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣶⠋⠀⠀⠀⠀⢀⣠⡤⠖⠒⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⣾⠁⠀⠀⠀⢀⣴⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡴⠶⣦⠀⠀⠀⠀⠀⠀⠀
⢸⣧⠀⠀⠀⢀⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⠞⠁⠀⠀⣿⠀⠀⢀⣶⣦⠀⠀
⢸⡀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢴⠟⠁⠀⠀⠀⠀⠿⠶⢴⣟⡀⢹⡆⠀
⠘⣷⠀⠀⠀⠈⢷⡄⣀⡤⠶⠚⠋⠉⠉⠉⠉⠉⠙⠓⠶⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢶⣷⠀
⠀⠘⢷⡀⠀⠀⠀⠙⢿⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢷⣄⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⢻⡀
⠀⠀⠈⢻⣦⡀⠀⠀⠀⠀⠉⠛⢦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣷⡍⠉⠹⣶⠀⠀⠀⢀⣶⣾⡇
⠀⠀⢠⡞⠈⠛⠶⢤⣀⣀⠀⠀⠀⠈⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⠀⠀⠀⣴⣶⣦⠙⠀⢠⡗
⠀⢀⡟⠀⠀⠀⠀⠀⠀⠈⣀⠀⡄⢀⡈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣧⠀⠷⠼⢿⣏⣄⢀⣼⠇
⠀⢸⣧⠀⠀⠀⠀⠀⠀⠀⢠⠿⣿⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠀⠀⠀⢀⣉⣽⠟⠃⠀
⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⡞⢻⡯⠉⠀⠀⠀⠀
⠀⢸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⡀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀
⠀⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⣶⠀⢸⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢹⡆⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⢠⠇⠀⠀⠀⠀⠀⢠⡟⢁⣾⠃⠀⢸⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢻⡀⠀⠀⠀⠙⠷⣤⣀⠀⠀⠀⠀⣸⡀⠀⠀⠀⠀⠀⣸⣷⠟⡇⠀⠀⠛⢷⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣷⡀⠀⠀⠀⠀⠸⡏⠉⠉⠉⠉⢻⠃⠀⠀⠀⠀⢠⡏⠁⠀⠻⣦⣤⣤⠾⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣸⠷⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠺⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢿⣁⠀⠀⠀⠀⢀⣿⠀⠀⠀⠀⠘⣧⡀⠀⣀⣀⣠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠉⠉⠉⠙⠛⠋⠁⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]],
				},
			},
		},
		keys = {
			{
				"<leader>bb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},

			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},

			{
				"<leader>bo",
				function()
					Snacks.bufdelete.other()
				end,
				desc = "Delete Other Buffers",
			},

			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File explorer",
			},

			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "LazyGit",
			},

			-- Git
			{
				"<leader>gi",
				function()
					Snacks.picker.gh_issue()
				end,
				desc = "GitHub Issues (open)",
			},
			{
				"<leader>gI",
				function()
					Snacks.picker.gh_issue({ state = "all" })
				end,
				desc = "GitHub Issues (all)",
			},
			{
				"<leader>go",
				function()
					Snacks.gitbrowse.open()
				end,
				desc = "Open Repository",
			},
			-- {
			-- 	"<leader>gp",
			-- 	function()
			-- 		Snacks.picker.gh_pr()
			-- 	end,
			-- 	desc = "GitHub Pull Requests (open)",
			-- },
			-- {
			-- 	"<leader>gP",
			-- 	function()
			-- 		Snacks.picker.gh_pr({ state = "all" })
			-- 	end,
			-- 	desc = "GitHub Pull Requests (all)",
			-- },

			-- Picker
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Find Text",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Find Buffers",
			},

			{
				"<leader>fh",
				function()
					Snacks.picker.help()
				end,
				desc = "Find Help",
			},

			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Find Recent",
			},

			{
				"<leader>fs",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "Find LSP Symbols",
			},

			{
				"<leader>ft",
				function()
					Snacks.picker.todo_comments()
				end,
				desc = "Find TODOs",
			},

			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "Find Projects",
			},

			-- Terminal
			{
				"<C-/>",
				function()
					Snacks.terminal()
				end,
				mode = { "n", "t" },
				desc = "Terminal",
			},
		},
	},
}
