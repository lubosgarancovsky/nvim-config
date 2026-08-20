local M = {}

function M.goto_definition()
	local params = vim.lsp.util.make_position_params()

	vim.lsp.buf_request_all(0, "textDocument/definition", params, function(results)
		local locations = {}

		for _, result in pairs(results) do
			if result.result then
				for _, location in ipairs(result.result) do
					table.insert(locations, location)
				end
			end
		end

		-- Filter unwanted paths
		locations = vim.tbl_filter(function(location)
			local uri = location.uri or location.targetUri

			if not uri then
				return false
			end

			local path = vim.uri_to_fname(uri)

			return not path:match("/node_modules/")
				and not path:match("/%.yarn/")
				and not path:match("/%.git/")
				and not path:match("/build/")
				and not path:match("/dist/")
		end, locations)

		if #locations == 0 then
			vim.notify("No definition found", vim.log.levels.INFO)
		elseif #locations == 1 then
			vim.lsp.util.jump_to_location(locations[1], "utf-8")
		else
			-- Snacks picker
			Snacks.picker.lsp_definitions()
		end
	end)
end

return M
