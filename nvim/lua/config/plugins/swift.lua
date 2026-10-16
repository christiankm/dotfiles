return {
	-- Swift syntax highlighting
	{
		"keith/swift.vim",
		ft = "swift",
	},

	-- 1. Main plugin to manage iOS targets, simulators, and builds
	{
		"wojciech-kulik/xcodebuild.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "MunifTanjim/nui.nvim" },
		config = function()
			require("xcodebuild").setup({
				-- Highly recommended to see beautiful build output logs
				logs = {
					notify_on_success = true,
					notify_on_failure = true,
				},
			})

			-- Keymaps for building, running, and picking device targets
			vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
			vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
			vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildRun<cr>", { desc = "Run Project" })
			vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectProject<cr>", { desc = "Select Project/Package" })
			vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device/Simulator" })
		end,
	},

	-- 2. Debugger integration (requires lldb-dap)
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")

			-- Connect dap to the system's lldb-dap tool executable
			dap.adapters.lldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "xcrun",
					args = { "lldb-dap", "--port", "${port}" },
				},
			}
		end,
	},
}
