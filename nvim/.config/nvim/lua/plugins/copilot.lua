return {
  -- Ajouter copilot.lua
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot", -- Charge le plugin uniquement lorsque la commande Copilot est utilisée
    event = "InsertEnter", -- Optionnel : charge en mode insertion
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-l>", -- Clé pour accepter une suggestion
            next = "<C-j>", -- Clé pour aller à la suggestion suivante
            prev = "<C-k>", -- Clé pour aller à la suggestion précédente
            dismiss = "<C-h>", -- Clé pour ignorer une suggestion
          },
        },
        panel = {
          enabled = true,
          auto_refresh = true,
          layout = {
            position = "bottom", -- Panel en bas
            ratio = 0.4,
          },
        },
      })
    end,
  },
}

