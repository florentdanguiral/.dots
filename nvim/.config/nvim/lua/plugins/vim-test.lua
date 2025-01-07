return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
    "mfussenegger/nvim-dap",  -- Assure-toi que nvim-dap est une dépendance
  },
  config = function()
    -- Définir le runner pour vim-test
    vim.g.test_runner = 'nvim-dap'

    -- Définir les keymaps pour vim-test
    vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", { silent = true })
    vim.keymap.set("n", "<leader>T", ":TestFile<CR>", { silent = true })
    vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", { silent = true })
    vim.keymap.set("n", "<leader>l", ":TestLast<CR>", { silent = true })
    vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", { silent = true })
    vim.cmd("let test#strategy = 'vimux'")
  end,

}

