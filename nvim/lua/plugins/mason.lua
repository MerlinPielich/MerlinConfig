-- lua/plugins/mason.lua
return {
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		-- explicit setup to ensure mason is initialized early
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
				"asm_lsp",
				"pyright",
				"bashls",
				"jsonls",
			},
		},
		config = function(_, opts)
			local mlc = require("mason-lspconfig")
			mlc.setup(opts)
			-- keep registration/starting of servers inside lspconfig.lua (single source of truth)
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		opts = {
			servers = {
				-- regular servers:
				lua_ls = {
					settings = { -- server settings go inside `settings`
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							telemetry = { enable = false },
							diagnostics = { globals = { "vim" } },
						},
					},
				},

				clangd = {},
				asm_lsp = {},
				bashls = {},
				jsonls = {},
				ts_ls = {},
				cspell_ls = {}, -- if you use a custom cspell setup, configure below
				cssls = {},
				tailwindcss = {
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
									{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								},
							},
						},
					},
				},
				prismals = {},
			},
		},

		config = function(_, opts)
			-- on_attach and keymaps
			local on_attach = function(_, buf)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
				end
				-- nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
				nmap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
				nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
				nmap("gI", vim.lsp.buf.implementation, "Goto Implementation")
				nmap("gD", vim.lsp.buf.type_definition, "Goto Type Definition")
				-- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
			end

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

			-- Register servers safely
			for server_name, server_spec in pairs(opts.servers or {}) do
				local cfg = {
					capabilities = capabilities,
					on_attach = on_attach,
				}

				-- pull top-level keys out of server_spec (if they exist)
				if server_spec.cmd then
					cfg.cmd = server_spec.cmd
				end
				if server_spec.filetypes then
					cfg.filetypes = server_spec.filetypes
				end
				if server_spec.root_dir then
					cfg.root_dir = server_spec.root_dir
				end
				if server_spec.on_new_config then
					cfg.on_new_config = server_spec.on_new_config
				end

				-- server settings (only non-function values) go under `settings`
				-- copy server_spec and remove the keys we moved to top-level
				local copy = vim.tbl_deep_extend("force", {}, server_spec)
				copy.cmd, copy.filetypes, copy.root_dir, copy.on_new_config = nil, nil, nil, nil

				if next(copy) then
					-- if the remaining fields are named `settings`, use that; otherwise use the remaining table as settings
					if copy.settings then
						cfg.settings = copy.settings
					else
						cfg.settings = copy
					end
				end

				-- register the server config using the modern API
				local ok, err = pcall(function()
					vim.lsp.config(server_name, cfg)
				end)
				if not ok then
					vim.notify(
						("lspconfig: failed to register %s: %s"):format(server_name, tostring(err)),
						vim.log.levels.WARN
					)
				end
			end

			-- enable all registered servers (start them lazily on file open)
			local registered = {}
			for name, _ in pairs(opts.servers or {}) do
				table.insert(registered, name)
			end
			if #registered > 0 then
				pcall(function()
					vim.lsp.enable(registered)
				end)
			end
		end,
	},
}
