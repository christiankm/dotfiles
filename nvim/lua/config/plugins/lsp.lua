-- Configure LSPs

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		opts = {
			servers = {
				lua_ls = {},
				sourcekit = {
					cmd = { "xcrun", "sourcekit-lsp" },
					filetypes = { "swift", "objective-c", "objective-cpp" },
					root_dir = function(filename, _)
						-- Looks for Package.swift first to prioritize your Swift Package setup
						local util = require("lspconfig.util")
						return util.root_pattern("buildServer.json")(filename)
							or util.root_pattern("Package.swift", ".git")(filename)
					end,
				},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end,
	},
}
