local cfg = require("config.settings").load()

return {
	{
		"milanglacier/minuet-ai.nvim",
		enabled = cfg.ai.enabled,
		config = function()
			require("minuet").setup({
				provider = "openai_fim_compatible",
				n_completions = 1,
				context_window = 512,
				request_timeout = 3,
				provider_options = {
					openai_fim_compatible = {
						api_key = "TERM",
						name = "Ollama",
						end_point = "http://localhost:11434/v1/completions",
						model = cfg.ai.completion_model,
						optional = {
							max_tokens = 56,
							top_p = 0.9,
						},
					},
				},
				virtualtext = {
					auto_trigger_ft = { "*" },
					hl_group = "Comment",
					keymap = {
						accept = "<A-A>",
						accept_line = "<A-a>",
						accept_n_lines = "<A-z>",
						next = "<A-]>",
						prev = "<A-[>",
						dismiss = "<A-e>",
					},
				},
			})
		end,
	},

	{
		"olimorris/codecompanion.nvim",
		enabled = cfg.ai.enabled,
		version = "^19.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>ac",
				"<cmd>CodeCompanionChat Toggle<cr>",
				desc = "AI Chat",
				mode = { "n", "v" },
			},
			{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI actions", mode = { "n", "v" } },
			{ "<leader>ae", "<cmd>CodeCompanionChat Add<cr>", desc = "AI add selection to chat", mode = "v" },
		},

		config = function()
			require("codecompanion").setup({
				adapters = {
					http = {
						ollama = function()
							return require("codecompanion.adapters").extend("ollama", {
								schema = {
									model = {
										default = cfg.ai.chat_model,
									},
									num_ctx = {
										default = 8192,
									},
								},
							})
						end,
					},
				},
				interactions = {
					chat = {
						adapter = "ollama",
					},
					inline = {
						adapter = "ollama",
					},
				},
				tools = {
					opts = {
						default_tools = { "agent" },
					},
				},
				display = {
					chat = {
						window = {
							layout = "vertical",
							position = "left",
							width = 0.4,
						},
					},
				},
			})
		end,
	},
}
