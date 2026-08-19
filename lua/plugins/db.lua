local cfg = require("config.settings").load()

return {
	{
		"tpope/vim-dadbod",
		lazy = true,
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
			"DBUILastQueryInfo",
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_show_help = 0
			vim.g.db_ui_use_nvim_notify = 1

			-- Where saved queries are stored
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

			-- Automatically execute queries when opening them
			vim.g.db_ui_auto_execute_table_helpers = 1

			-- Keep the DBUI sidebar open when opening a table/query
			vim.g.db_ui_win_position = "left"
			vim.g.db_ui_winwidth = 35

			-- Connections
			vim.g.dbs = cfg.db.connections

			vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<cr>", {
				desc = "Database UI",
			})

			vim.keymap.set("n", "<leader>df", "<cmd>DBUIFindBuffer<cr>", {
				desc = "Find DB buffer",
			})

			vim.keymap.set("n", "<leader>dq", "<cmd>DBUILastQueryInfo<cr>", {
				desc = "Last query info",
			})

			vim.keymap.set("n", "<leader>dr", "<cmd>DBUIRenameBuffer<cr>", {
				desc = "Rename DB buffer",
			})
		end,
	},

	{
		"kristijanhusak/vim-dadbod-completion",
		ft = {
			"sql",
			"mysql",
			"plsql",
		},
		dependencies = {
			"tpope/vim-dadbod",
		},
	},
}
