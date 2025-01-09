return {
	"mfussenegger/nvim-dap",
	--commit = "7ff6936010b7222fea2caea0f67ed77f1b7c60dd",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
		"jay-babu/mason-nvim-dap.nvim",
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
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = {
				"js",
			},
			automatic_installation = true,
		})

		require("dap").adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				-- 💀 Make sure to update this path to point to your installation
				args = {
					"/home/flo/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"${port}",
				},
			},
		}

		for _, language in ipairs({ "typescript", "javascript", "svelte" }) do
			require("dap").configurations[language] = {
				-- Node.js configuration
				{
					type = "pwa-node",
					request = "attach",
					processId = require("dap.utils").pick_process,
					name = "Attach debugger to existing `node --inspect` process",
					sourceMaps = true,
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
					cwd = "${workspaceFolder}",
					skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
				},
				-- Chrome configuration
				{
					type = "pwa-chrome",
					name = "Launch Chrome to debug client",
					request = "launch",
					url = "http://localhost:4200",
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}",
					skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Debug Karma Tests",
					url = "http://localhost:9876/debug.html",
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					skipFiles = { "**/node_modules/**/*" },
					preLaunchTask = "ng test",
				},
				{
					type = "pwa-chrome",
					name = "Attach to Chrome",
					request = "attach",
					port = 9222,
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
					protocol = "inspector",
					skipFiles = { "**/node_modules/**/*" },
				},
				-- React Native Metro bundler (attach mode)
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to React Native Metro",
					port = 8081, -- Port utilisé par Metro
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					skipFiles = { "**/node_modules/**/*" },
				},
				-- React Native Android
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch React Native Android",
					cwd = vim.fn.getcwd(),
					runtimeExecutable = "react-native",
					runtimeArgs = { "run-android" },
					sourceMaps = true,
					protocol = "inspector",
					skipFiles = { "**/node_modules/**/*" },
				},
				-- React Native iOS
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch React Native iOS",
					cwd = vim.fn.getcwd(),
					runtimeExecutable = "react-native",
					runtimeArgs = { "run-ios" },
					sourceMaps = true,
					protocol = "inspector",
					skipFiles = { "**/node_modules/**/*" },
				},
				-- Firefox configuration
				{
					type = "firefox",
					name = "Launch Firefox to debug client",
					request = "launch",
					url = "http://localhost:5173",
					webRoot = "${workspaceFolder}",
					firefoxExecutable = "/usr/bin/firefox", -- Modifiez selon votre système
					sourceMaps = true,
					skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to NestJS2",
					port = 9229,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					protocol = "inspector",
					localRoot = vim.fn.getcwd(), -- Ajoutez les parenthèses ici pour obtenir une chaîne
					remoteRoot = "/app",
					skipFiles = { "**/node_modules/**/*" },
				},
				{
					name = "Launch NestJS Test",
					type = "pwa-node",
					request = "launch",
					program = "${workspaceFolder}/node_modules/.bin/jest",
					args = { "${file}" },
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
				-- Only for JavaScript: launch the current file in a new Node.js process
				language == "javascript"
						and {
							type = "pwa-node",
							request = "launch",
							name = "Launch file in new node process",
							program = "${file}",
							firefoxExecutable = "/usr/bin/firefox --new-window --detach",
							cwd = "${workspaceFolder}",
						}
					or nil,
			}
		end

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
