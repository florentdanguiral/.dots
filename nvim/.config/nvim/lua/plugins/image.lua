local log_file = "/tmp/nvim_debug.log"
local function log_to_file(msg)
  local file = io.open(log_file, "a")
  file:write(msg .. "\n")
  file:close()
end
return {
  "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = {
      {

            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = { "markdown" },
                    highlight = { enable = true },
                })
            end,
        },
    },
opts = {
    backend = "kitty",
    integrations = {
        markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            floating_windows = true
        },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
}

  }


