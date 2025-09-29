require('notify').setup({
    -- Increase the max_width to allow longer messages to be displayed.
    -- A value of 100 or 120 is usually a good starting point.
    max_width = 39,

    -- You can also set a max_height if you expect very long, multi-line notifications
    max_height = 35,

    timeout = 565,
    background_colour = "#000000",
})

-- Apply custom border color for INFO level notifications
vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = "#00ff00" })

-- Replace vim.notify with notify.nvim
vim.notify = require('notify')
