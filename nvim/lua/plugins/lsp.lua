-- Configure LSPs
--
-- The servers here are merged into the kickstart LSP config in init.lua, which passes each one
-- to vim.lsp.config() and vim.lsp.enable(). blink.cmp adds its capabilities to every server itself.

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
					root_dir = function(bufnr, on_dir)
						-- Prefers the folder with buildServer.json (xcode-build-server), then the nearest
						-- Package.swift or .git
						on_dir(vim.fs.root(bufnr, "buildServer.json") or vim.fs.root(bufnr, { "Package.swift", ".git" }))
					end,
				},
			},
		},
	},
}
