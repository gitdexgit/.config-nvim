-- File: ~/.config/nvim/after/plugin/scrollbar.lua

local status_ok, scrollbar = pcall(require, "scrollbar")
if not status_ok then
  return
end

scrollbar.setup({


    show_in_active_only = false,
    set_highlights = true,
    -- show = false,
    -- [[ THEME TWEAK #1: A SUBTLE HANDLE ]]
    -- Let's make the handle blend in nicely.
    handle = {
        -- text = " ",
        -- Highlight linked to 'ColorColumn' or 'CursorLine' is often subtle.
        -- This is a key change for the look.
        highlight = "ColorColumn", 
        hide_if_all_visible = true, -- Hides handle if all lines are visible
        -- 'blend' makes the handle semi-transparent (0=solid, 100=invisible)
        blend = 75, 
    },

  -- [[ THEME TWEAK #2: THINNER MARKS ]]
  -- Instead of solid blocks, we'll use thin lines.
  -- marks = {
  --     GitAdd = {
  --         name = "GitAdd",
  --         -- text = "│", -- Changed from '█' to a thin vertical bar
  --         text = "-", -- Changed from '█' to a thin vertical bar
  --         highlight = "GitSignsAdd",
  --     },
  --     GitChange = {
  --         name = "GitChange",
  --         -- text = "│", -- Changed from '█' to a thin vertical bar
  --         text = "-", -- Changed from '█' to a thin vertical bar
  --         highlight = "GitSignsChange",
  --     },
  --     GitDelete = {
  --         name = "GitDelete",
  --         text = "─", -- A thin horizontal bar for deletions
  --         -- text = "X", -- Changed from '█' to a thin vertical bar
  --         highlight = "GitSignsDelete",
  --     },
  --
  --     DiagnosticError = {
  --         name = "DiagnosticError",
  --         text = "─", -- Changed from '█' to a thin horizontal bar
  --         text = "─", -- Changed from '█' to a thin horizontal bar
  --         highlight = "DiagnosticSignError",
  --     },
  --     DiagnosticWarn = {
  --         name = "DiagnosticWarn",
  --         text = "─", -- Changed from '█' to a thin horizontal bar
  --         highlight = "DiagnosticSignWarn",
  --     },
  --     DiagnosticInfo = {
  --         name = "DiagnosticInfo",
  --         text = "─", -- Changed from '█' to a thin horizontal bar
  --         highlight = "DiagnosticSignInfo",
  --     },
  --     DiagnosticHint = {
  --         name = "DiagnosticHint",
  --         text = "─", -- Changed from '█' to a thin horizontal bar
  --         highlight = "DiagnosticSignHint",
  --     },
  -- },

  -- Handlers remain the same, they work great.
     handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true, -- Requires gitsigns
        handle = true,
        search = false, -- Requires hlslens
        ale = false, -- Requires ALE
    }, 


  excluded_filetypes = {
    "prompt",
    "TelescopePrompt",
    "NvimTree",
    "neo-tree",
    "lazy",
    "mason",
  },
})

-- This line is still crucial!
require("scrollbar.handlers.gitsigns").setup()
