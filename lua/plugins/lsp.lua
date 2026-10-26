return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"typescript-language-server",
				"tailwindcss-language-server",
				"eslint-lsp",
				"eslint_d",
				"prettierd",
				"css-lsp",
				"json-lsp",
				"lua-language-server",
				"stylua",
				"harper-ls",
				"yaml-language-server",
				"gopls",
				"clangd",
				"clang-format",
				"pyright",
				"ruff",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",

		event = { "BufReadPre", "BufNewFile" },

		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},

		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
			},

			inlay_hints = {
				enabled = false,
			},

			codelens = {
				enabled = false,
			},

			servers = {
				["*"] = {
					capabilities = {
						workspace = {
							fileOperations = {
								didRename = true,
								willRename = true,
							},
						},
					},

					keys = {
						{
							"gd",
							vim.lsp.buf.definition,
							desc = "Go to Definition",
						},
						{
							"gD",
							vim.lsp.buf.declaration,
							desc = "Go to Declaration",
						},
						{
							"gi",
							vim.lsp.buf.implementation,
							desc = "Go to Implementation",
						},
						{
							"gr",
							function()
								Snacks.picker.lsp_references()
							end,
							desc = "Go to References",
						},
						{
							"K",
							vim.lsp.buf.hover,
							desc = "Hover",
						},
						{
							"<leader>ca",
							vim.lsp.buf.code_action,
							desc = "Code Action",
						},
						{
							"<leader>cr",
							vim.lsp.buf.rename,
							desc = "Rename",
						},
						{
							"<leader>uh",
							function()
								local enabled = vim.lsp.inlay_hint.is_enabled({
									bufnr = 0,
								})

								vim.lsp.inlay_hint.enable(not enabled, {
									bufnr = 0,
								})
							end,
							desc = "Toggle Inlay Hints",
						},
					},
				},

				ts_ls = {
					settings = {
						javascript = {
							inlayHints = {
								includeInlayEnumMemberValueHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayVariableTypeHints = true,
							},
						},
						typescript = {
							inlayHints = {
								includeInlayEnumMemberValueHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayVariableTypeHints = true,
							},
						},
					},
					keys = {
						{
							"<leader>co",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.organizeImports" },
										diagnostics = {},
									},
								})
							end,
							desc = "Organize Imports",
						},
						{
							"<leader>cM",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.addMissingImports.ts" },
										diagnostics = {},
									},
								})
							end,
							desc = "Add missing imports",
						},
						{
							"<leader>cu",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.removeUnused.ts" },
										diagnostics = {},
									},
								})
							end,
							desc = "Remove unused imports",
						},
						{
							"<leader>cF",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.fixAll.ts" },
										diagnostics = {},
									},
								})
							end,
							desc = "Fix all diagnostics",
						},
					},
				},

				tailwindcss = {
					filetypes = {
						"html",
						"css",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
					settings = {
						tailwindCSS = {
							classFunctions = { "cva", "cx" },
						},
					},
				},

				cssls = {
					settings = {
						css = {
							validate = true,
						},

						scss = {
							validate = true,
						},

						less = {
							validate = true,
						},
					},
				},

				jsonls = {
					settings = {
						json = {
							validate = {
								enable = true,
							},
						},
					},
				},

				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},

							diagnostics = {
								globals = {
									"vim",
								},
							},

							workspace = {
								checkThirdParty = false,
							},

							telemetry = {
								enable = false,
							},
						},
					},
				},

				harper_ls = {},

				yamlls = {},

				gopls = {
					settings = {
						gopls = {
							gofumpt = true,
							staticcheck = true,
							usePlaceholders = true,
							analyses = {
								unusedparams = true,
								unusedwrite = true,
								nilness = true,
							},
						},
					},
				},

				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--completion-style=detailed",
					},
				},

				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
								typeCheckingMode = "standard",
							},
						},
					},
				},
			},
		},

		config = function(_, opts)
			vim.diagnostic.config(opts.diagnostics)

			for server_name, server_opts in pairs(opts.servers) do
				local config = vim.deepcopy(server_opts)
				config.keys = nil
				vim.lsp.config(server_name, config)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if not client then
						return
					end

					if opts.inlay_hints.enabled and client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, {
							bufnr = event.buf,
						})
					end

					if opts.codelens.enabled and client:supports_method("textDocument/codeLens") then
						vim.lsp.codelens.refresh()
					end

					local server_opts = opts.servers[client.name] or {}
					local default_opts = opts.servers["*"] or {}

					local keys = {}

					vim.list_extend(keys, default_opts.keys or {})
					vim.list_extend(keys, server_opts.keys or {})

					for _, key in ipairs(keys) do
						vim.keymap.set(key.mode or "n", key[1], key[2], {
							buffer = event.buf,
							desc = key.desc,
							silent = true,
						})
					end
				end,
			})

			require("mason-lspconfig").setup()
		end,
	},
}
