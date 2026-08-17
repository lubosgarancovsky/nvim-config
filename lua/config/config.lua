local M = {
	ui = {
		transparent = true,
	},
	ai = {
		enabled = true,
		chat_model = "ornith:9b",
		completion_model = "qwen2.5-coder:7b",
	},
	db = {
		connections = {},
	},
}

return M
