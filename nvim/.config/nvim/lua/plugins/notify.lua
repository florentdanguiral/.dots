return {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")
        notify.setup({
            stages = "fade", -- Vous pouvez configurer des effets comme fade, slide, etc.
            timeout = 3000, -- Durée des notifications
            background_colour = "#000000", -- Couleur de fond
        })
        vim.notify = notify -- Redirige les notifications de Neovim vers nvim-notify
    end,
}

