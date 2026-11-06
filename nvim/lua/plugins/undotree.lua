-- Undotree, for browsing the undo history as a tree

return {
    "mbbill/undotree",
    config = function()
        -- toggle the undo tree
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
}
