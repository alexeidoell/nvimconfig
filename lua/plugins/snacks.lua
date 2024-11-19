return {

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            dashboard = { enabled = true },
            notifier = 
            { 
                enabled = true,
                style = "compact",
                icons = {
                    error = "",
                    warn = "",
                    info = "",
                    debug = "",
                    trace = "",
                },
            },
            words = { enabled = true },
        },
    }

}
