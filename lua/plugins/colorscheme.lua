return {
    {
        "yorumicolors/yorumi.nvim",
        lazy = true,
        name = "yorumi",
        init = function()
            vim.cmd.colorscheme("yorumi")
        end,
    },
}
