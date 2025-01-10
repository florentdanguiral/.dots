return {
	"saghen/blink.cmp",
	version = "*",
	signature = { enabled = true },
	opts = {
		keymap = {
			preset = "super-tab",
			["<C-y>"] = { "select_and_accept" },
		},
		appearance = {
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			nerd_font_variant = "mono",
		},

		-- list of enabled providers t
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		snippets = {
			preset = "luasnip",
		},
	},
	opts_extend = { "sources.default" },
}
