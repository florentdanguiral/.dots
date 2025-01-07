return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"markdown",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"lua",
				"python",
				"bash",
				"yaml",
				"toml",
			},
			highlight = { enable = true },
		})
	end,
}
