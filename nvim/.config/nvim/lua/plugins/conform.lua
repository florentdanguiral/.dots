return {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		config = function()
			require("conform").setup({
				linters_by_ft = {
					lua = { "luacheck" },
					javascript = { "eslint" },
					typescript = { "eslint" },
					javascriptreact = { "eslint" },
					typescriptreact = { "eslint" },
					css = { "stylelint" },
					scss = { "stylelint" },
					sass = { "stylelint" },
				},
				formatters_by_ft = {
					markdown = { "prettier" },
					lua = { "stylua" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					sass = { "prettier" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
				},
				format_on_save = true,
				timeout_ms = 500,
			})
		end,
	},
}
