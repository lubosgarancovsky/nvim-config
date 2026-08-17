return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
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
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
		},

		opts_extend = { "servers.*.keys" },

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
				enabled = true,
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
							"<leader>cd",
							vim.lsp.buf.definition,
							desc = "Definition",
						},
						{
							"<leader>cr",
							vim.lsp.buf.references,
							desc = "References",
						},
						{
							"<leader>ci",
							vim.lsp.buf.implementation,
							desc = "Implementation",
						},
						{
							"<leader>ct",
							vim.lsp.buf.type_definition,
							desc = "Type Definition",
						},
						{
							"<leader>ca",
							vim.lsp.buf.code_action,
							desc = "Code Action",
						},
						{
							"<leader>cn",
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
							implicitProjectConfig = {
								checkJs = true,
							},
						},
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
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

			vim.lsp.enable({
				"ts_ls",
				"tailwindcss",
				"cssls",
				"jsonls",
				"lua_ls",
				"harper_ls",
				"yamlls",
				"gopls",
				"clangd",
				"pyright",
			})

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
		end,
	},
}
