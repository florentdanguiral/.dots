return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  opts = {
    defaults = {
      ["<leader>"] = {
        f = { name = "File" }, -- Préfixe pour les commandes liées aux fichiers
        g = { name = "Git" },  -- Préfixe pour Git
        b = { name = "Buffer" }, -- Préfixe pour les buffers
        w = { ":w<CR>", "Save File" }, -- Sauvegarder le fichier actuel
        z = { name = "Custom Shortcuts" }, -- Votre groupe personnalisé
      },
    },
  },
}
