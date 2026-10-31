return {
	-- Crashdummyy's registry ships the `roslyn` package, the same Roslyn
	-- language server build that VS Code's C# extension uses.
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},

	-- C# and Razor/Blazor LSP. Install the server once with `:MasonInstall roslyn`.
	-- Use `:Roslyn target` to pick a solution when a repo has more than one.
	{
		"seblyng/roslyn.nvim",
		ft = { "cs", "razor" },
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		opts = {},
		config = function(_, opts)
			vim.lsp.config("roslyn", {
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
				},
			})
			require("roslyn").setup(opts)
		end,
	},
}
