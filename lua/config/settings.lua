local M = {
	ui = {
		transparent = false,
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
	ai = {
		enabled = false,
		completion_model = "",
		chat_model = "",
	},
	db = {
		connections = {},
	},
}

local function merge(defaults, overrides)
	local result = vim.deepcopy(defaults)

	for key, value in pairs(overrides or {}) do
		if type(value) == "table" and type(result[key]) == "table" then
			result[key] = merge(result[key], value)
		else
			result[key] = value
		end
	end

	return result
end

function M.load()
	local ok, local_config = pcall(require, "config.local")

	if not ok then
		return vim.deepcopy(M)
	end

	if type(local_config) ~= "table" then
		error("config.local must return a table")
	end

	return merge(M, local_config)
end

return M
