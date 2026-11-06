-- Fugitive, for running git from inside Neovim

return {
    "tpope/vim-fugitive",
    config = function()
        -- open the git status window
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end,
}
