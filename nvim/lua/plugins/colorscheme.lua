return {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("rose-pine").setup({
            variant = "main",
            styles = {
                italic = false,
            },
        })

        vim.cmd.colorscheme("rose-pine")

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
}
