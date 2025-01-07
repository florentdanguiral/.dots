return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    default = {
      dir_path = "attachments",
      extension = "webp",
      prompt_for_file_name = true,
      file_name = "%y%m%d-%H%M%S",
    },
    filetypes = {
      markdown = {
        url_encode_path = true,
        template = "![$CURSOR]($FILE_PATH)",
        download_images = false,
      },
      html = {
        template = '<img src="$FILE_PATH" alt="$CURSOR">', ---@type string | fun(context: table): string
      },
    },
  },
  keys = {
    -- suggested keymap
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
