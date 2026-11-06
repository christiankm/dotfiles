-- Neo-tree is a Neovim plugin to browse the file system

---@module 'lazy'
---@type LazySpec
return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	keys = {
		{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
	},
	---@module 'neo-tree'
	---@type neotree.Config
	opts = {
		filesystem = {
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = true,
				never_show = {
					-- ".git",
					-- ".build",
					-- "node_modules",
					-- "bin",
					-- "build",
					-- "obj",
					-- ".DS_Store"
				},
			},
			window = {
				mappings = {
					["\\"] = "close_window",
				},
			},
		},
	},
}
