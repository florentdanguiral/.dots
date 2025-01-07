return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true, -- Utilise une interface en bas pour la recherche
                command_palette = true, -- Active un style de palette pour les commandes
                long_message_to_split = true, -- Divise les longs messages dans un split
                inc_rename = false, -- Désactiver si non utilisé avec inc-rename.nvim
                lsp_doc_border = true, -- Ajoute une bordure aux docs LSP
            },
        })
    end,
}

