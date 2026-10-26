-- Run from the config directory: nvim --headless -u NONE -n -i NONE -l tests/smoke.lua
local root = vim.fn.fnamemodify("tests/smoke.lua", ":p:h:h")
local fixture_dir = vim.fn.tempname()

local function run()
	-- Do not use personal connections/models or send AI requests during this test.
	package.loaded["config.local"] = {
		ai = { enabled = true, chat_model = "smoke-test", completion_model = "smoke-test" },
		db = { connections = {} },
	}
	vim.opt.rtp:prepend(root)
	vim.go.loadplugins = true
	dofile(root .. "/init.lua")
	require("lazy").load({ plugins = { "nvim-lspconfig", "vim-dadbod-ui", "codecompanion.nvim", "overseer.nvim" } })

	local ts = vim.lsp.config.ts_ls
	assert(ts.settings.typescript.inlayHints.includeInlayParameterNameHints == "all", "TypeScript settings lost")
	assert(vim.lsp.config.gopls.settings.gopls.gofumpt, "Go settings lost")
	assert(vim.lsp.config.pyright.settings.python.analysis.typeCheckingMode == "standard", "Pyright settings lost")
	assert(vim.lsp.config.lua_ls.settings.Lua.telemetry.enable == false, "Lua settings lost")
	assert(vim.deep_equal(vim.lsp.config.tailwindcss.settings.tailwindCSS.classFunctions, { "cva", "cx" }))
	assert(vim.tbl_contains(vim.lsp.config.clangd.cmd, "--clang-tidy"), "clangd flags lost")
	assert(ts.capabilities.workspace.fileOperations.willRename, "File rename capability lost")
	assert(ts.capabilities.textDocument.completion.completionItem.snippetSupport, "Blink capabilities lost")
	assert(ts.keys == nil and vim.lsp.config["*"].keys == nil, "Keymaps leaked into LSP configuration")
	assert(vim.lsp.is_enabled("ts_ls"), "Mason did not enable TypeScript")

	local chat = require("codecompanion.config").interactions.chat
	assert(vim.deep_equal(chat.tools.opts.default_tools, { "agent" }), "Chat tools not configured")
	assert(vim.g.db_ui_execute_on_save == 0, "Saving SQL must not execute it")
	assert(vim.g.db_ui_auto_execute_table_helpers == 0, "Opening helpers must not execute SQL")

	local sources = require("blink.cmp.config").sources
	for _, ft in ipairs({ "sql", "mysql", "plsql" }) do
		assert(vim.tbl_contains(sources.per_filetype[ft], "dadbod"), "Dadbod source missing for " .. ft)
	end
	assert(sources.providers.dadbod.module == "vim_dadbod_completion.blink")
	assert(type(require("vim_dadbod_completion.blink").new) == "function", "Dadbod provider cannot load")

	io.stdout:write("PASS: LSP configuration, SQL provider/safety, AI tools\n")
	io.stdout:flush()

	-- Startup installs parsers asynchronously; allow a first-run installation to finish.
	local languages = {
		"bash",
		"c",
		"cpp",
		"css",
		"go",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"sql",
		"tsx",
		"typescript",
		"yaml",
	}
	assert(
		vim.wait(120000, function()
			for _, lang in ipairs(languages) do
				local ok, loaded = pcall(vim.treesitter.language.add, lang)
				if not ok or not loaded then
					return false
				end
			end
			return true
		end, 200),
		"Parser installation incomplete; check :messages and :TSInstall"
	)

	io.stdout:write("PASS: parser installation\n")
	io.stdout:flush()

	for _, ft in ipairs({
		"typescriptreact",
		"javascriptreact",
		"sh",
		"python",
		"c",
		"cpp",
		"sql",
		"yaml",
		"markdown",
		"lua",
	}) do
		vim.cmd.enew()
		vim.bo.filetype = ft
		assert(
			vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()],
			"No Tree-sitter highlighting for " .. ft
		)
	end
	assert(
		vim.wait(2000, function()
			return #require("luasnip").get_snippets("lua") > 0
		end),
		"Friendly Lua snippets did not load"
	)
	assert(#require("luasnip").get_snippets("typescriptreact") > 4, "Only custom React snippets loaded")

	vim.fn.mkdir(fixture_dir, "p")
	vim.fn.writefile({ '{"name":"nvim-smoke","lockfileVersion":3,"packages":{}}' }, fixture_dir .. "/package-lock.json")
	vim.fn.writefile({ '{"compilerOptions":{"strict":true}}' }, fixture_dir .. "/tsconfig.json")
	vim.fn.writefile({ 'const value: number = "wrong";' }, fixture_dir .. "/test.ts")
	vim.cmd.edit(fixture_dir .. "/test.ts")
	assert(
		vim.wait(15000, function()
			return #vim.lsp.get_clients({ bufnr = 0, name = "ts_ls" }) > 0 and #vim.diagnostic.get(0) > 0
		end, 100),
		"TypeScript did not attach and publish diagnostics"
	)
	assert(vim.fn.maparg("gd", "n", false, true).callback == vim.lsp.buf.definition, "gd is not the native LSP handler")
	assert(vim.fn.maparg(" co", "n", false, true).buffer == 1, "TypeScript keymaps did not attach")

	for ft, test in pairs({
		lua = { "local x={a=1,b=2}", "local x = { a = 1, b = 2 }" },
		typescript = { "const x={a:1,b:2}", "const x = { a: 1, b: 2 };" },
	}) do
		vim.cmd.enew()
		vim.bo.filetype = ft
		vim.api.nvim_buf_set_lines(0, 0, -1, false, { test[1] })
		local format_error
		require("conform").format({ async = false, timeout_ms = 5000 }, function(err)
			format_error = err
		end)
		assert(not format_error, tostring(format_error))
		assert(vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == test[2], "Formatting failed for " .. ft)
		vim.bo.modified = false
	end

	local task = require("overseer").new_task({ cmd = { "printf", "NVIM_SMOKE_OK" } })
	task:start()
	assert(
		vim.wait(5000, function()
			return task:is_complete()
		end),
		"Task timed out"
	)
	assert(task.exit_code == 0, "Overseer task failed")
	io.stdout:write("PASS: LSP attachment/diagnostics, gd, Tree-sitter, snippets, formatting, tasks\n")
	io.stdout:flush()
end

local ok, err = xpcall(run, debug.traceback)
vim.fn.delete(fixture_dir, "rf")
if not ok then
	io.stderr:write(err .. "\n")
	vim.cmd("cquit 1")
end
vim.cmd("qa!")
