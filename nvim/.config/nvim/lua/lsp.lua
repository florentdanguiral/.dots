local servers = {
	"tailwindcss",
	"ts_ls",
	"jsonls",
	"bashls",
	"yamlls",
	"html",
	"lua_ls",
	"cssls",
	"angularls",
	"marksman",
}

return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_update = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				auto_update = true,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"markdown-toc",
					"markdownlint-cli2",
					"prettier", -- Formateur universel (HTML, CSS, JS, etc.)
					"stylua", -- Formateur Lua
					"luacheck", -- Linter Lua
					"eslint", -- Linter pour JS/TS/JSX/TSX
					"stylelint", -- Linter pour CSS/Sass/SCSS
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		lazy = false,
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			for _, server in ipairs(servers) do
				lspconfig[server].setup({ capabilities = capabilities })
			end

			-- Raccourcis clavier pour les fonctionnalités LSP
			local map = vim.keymap.set
			map("n", "K", vim.lsp.buf.hover, {})
			map("n", "<leader>gd", vim.lsp.buf.definition, {})
			map("n", "<leader>gr", vim.lsp.buf.references, {})
			map("n", "<leader>ca", vim.lsp.buf.code_action, {})
			map("n", "<leader>rr", vim.lsp.buf.rename, {})
		end,
	},
}
