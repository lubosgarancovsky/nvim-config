return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			-- Neotest
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",

			-- JavaScript / TypeScript
			"marilari88/neotest-vitest",
			"nvim-neotest/neotest-jest",

			-- Python
			"nvim-neotest/neotest-python",

			-- Go
			{
				"fredrikaverpil/neotest-golang",
				version = "*",
			},

			-- C / C++
			"orjangj/neotest-ctest",
		},

		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run test file",
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.run(vim.fn.getcwd())
				end,
				desc = "Run all tests",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle test summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open()
				end,
				desc = "Open test output",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop test",
			},
		},

		config = function()
			local neotest = require("neotest")

			neotest.setup({
				adapters = {
					require("neotest-vitest"),
					require("neotest-jest"),
					require("neotest-python"),
					require("neotest-golang"),
					require("neotest-ctest").setup({}),
				},

				floating = {
					border = "rounded",
				},
			})
		end,
	},
}
