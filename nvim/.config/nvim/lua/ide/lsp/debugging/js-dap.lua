return {
	"mxsdev/nvim-dap-vscode-js",
	ft = { "svelte", "typescript", "javascript", "vue" },
	dependencies = {
		"mfussenegger/nvim-dap",
		{
			"microsoft/vscode-js-debug",
			version = "1.x",
			build = "npm i && npm run compile vsDebugServerBundle && rm -rf out && mv dist out",
		},
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		-- Setup dap-vscode-js for Chrome and Node.js
		require("dap-vscode-js").setup({
			debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		})

		-- Setup Mason and install Firefox adapter
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = { "firefox" },
		})

		-- Configure dap adapter for Firefox
		require("dap").adapters.firefox = {
			type = "executable",
			command = "node",
			args = { vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
		}

		-- Configure dap for various languages including Chrome and Firefox
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
	end,
}
