return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  enabled = true, -- Disable lualine for skitty mode
  config = function()
    local function spell_status()
      if vim.wo.spell then
        return 'Spell: On'  -- Affiche "Spell: On" si la vérification orthographique est activée
      else
        return 'Spell: Off'  -- Affiche "Spell: Off" si la vérification orthographique est désactivée
      end
    end
    local function file_permissions()
      local filename = vim.fn.expand('%:p')  -- Récupère le chemin absolu du fichier
      local stat = vim.loop.fs_stat(filename) -- Utilise libuv pour obtenir des informations sur le fichier
      if stat then
        local perms = stat.mode
        -- Convertir le mode en format lisible, par exemple 'rwxr-xr-x'
        local permission_string = ''
        permission_string = permission_string .. (bit.band(perms, 256) > 0 and 'r' or '-')
        permission_string = permission_string .. (bit.band(perms, 128) > 0 and 'w' or '-')
        permission_string = permission_string .. (bit.band(perms, 64) > 0 and 'x' or '-')
        permission_string = permission_string .. (bit.band(perms, 32) > 0 and 'r' or '-')
        permission_string = permission_string .. (bit.band(perms, 16) > 0 and 'w' or '-')
        permission_string = permission_string .. (bit.band(perms, 8) > 0 and 'x' or '-')
        permission_string = permission_string .. (bit.band(perms, 4) > 0 and 'r' or '-')
        permission_string = permission_string .. (bit.band(perms, 2) > 0 and 'w' or '-')
        permission_string = permission_string .. (bit.band(perms, 1) > 0 and 'x' or '-')
        return permission_string
      else
        return "No permissions"
      end
    end

    require("lualine").setup {
      sections = {
        lualine_x = { spell_status, "filetype", file_permissions },
      },
    }
  end,
}

