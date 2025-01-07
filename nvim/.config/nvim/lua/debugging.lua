return {
	"mfussenegger/nvim-dap",
	dependencies = {
    		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = {
		-- normal mode is default
		{
			"<leader>d",
			function()
				require("dap").toggle_breakpoint()
			end,
		},
		{
			"<leader>c",
			function()
				require("dap").continue()
			end,
		},
		{
			"<C-'>",
			function()
				require("dap").step_over()
			end,
		},
		{
			"<C-;>",
			function()
				require("dap").step_into()
			end,
		},
		{
			"<C-:>",
			function()
				require("dap").step_out()
			end,
		},
		{
			"<leader>t",
			function()
				require("dapui").toggle()
			end,
		},
		{
			"<leader>dc",
			function()
				require("telescope").extensions.dap.configurations({})
			end,
		},
		{
			"<leader>de",
			function()
				require("dapui").eval()
			end,
			mode = { "n", "v" }, -- Enable in normal and visual mode
		},
	},
	config = function()
    require("dapui").setup()
--		require("dap-go").setup()

		local dap, dapui = require("dap"), require("dapui")

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
		vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
		vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
		vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
	end,
}

