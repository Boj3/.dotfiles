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
		require("nvim-dap-virtual-text").setup()
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open({ reset = true })
		end
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
		require("telescope").load_extension("dap")
	end,
}
