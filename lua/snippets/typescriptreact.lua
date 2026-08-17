local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
--local d = ls.dynamic_node
--local sn = ls.snippet_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

local function component_name()
	local filename = vim.fn.expand("%:t:r")

	local parts = vim.split(filename, "[-_%s]+", {
		trimempty = true,
	})

	for index, part in ipairs(parts) do
		parts[index] = part:sub(1, 1):upper() .. part:sub(2)
	end

	return table.concat(parts)
end

ls.add_snippets("typescriptreact", {
	-- React Functional Component
	s("rfc", {
		t("import React, { FC } from 'react';"),
		t({ "", "", "type " }),
		i(1, "Props"),
		t({ " = {}", "", "", "const " }),

		f(component_name),

		t(": FC<"),
		rep(1),

		t({ "> = () => {", "    return <>" }),
		i(2),
		t({ "</>", "}", "", "export default " }),

		f(component_name),

		t(";"),
	}),

	-- useState
	s(
		"useState",
		fmt("const [{}, set{}] = useState<{}>({});", {
			i(1, "value"),
			i(2, "Value"),
			i(3, "string"),
			i(4),
		})
	),

	-- useEffect
	s(
		"useEffect",
		fmt(
			[[
useEffect(() => {{
  {}
}}, [{}]);
    ]],
			{
				i(1),
				i(2),
			}
		)
	),

	-- useRef
	s(
		"useRef",
		fmt("const {} = useRef<{}>({});", {
			i(1, "ref"),
			i(2, "HTMLDivElement"),
			i(3, "null"),
		})
	),
})
