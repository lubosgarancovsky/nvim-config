vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		source = "if_many",
	},

	signs = true,

	underline = true,

	update_in_insert = false,

	severity_sort = true,

	float = {
		border = "rounded",
		source = "if_many",
	},
})
