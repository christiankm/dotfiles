return {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("rose-pine").setup({
            variant = "main",
            palette = {
                main = {
                    text = "#c8c5de",
                    love = "#d07899",
                    gold = "#c5aa8b",
                    rose = "#d0aeb5",
                    pine = "#4e7b97",
                    foam = "#98bbca",
                    iris = "#b49fd5",
                },
            },
            styles = {
                italic = false,
            },
        })

        vim.cmd.colorscheme("rose-pine")

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
}
