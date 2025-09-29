-- File: after/plugin/undotree.lua

--- A helper function to check if the undotree window is currently open.
local function is_undotree_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == 'undotree' then
      return true -- We found it!
    end
  end
  return false
end

--- A smart toggle function that GUARANTEES focus returns to your original code window.
--- This ensures Telescope and other plugins continue to work correctly.
local function toggle_undotree_no_focus_steal()
  local was_open = is_undotree_open()

  -- Remember our starting window handle before the toggle command runs.
  local original_win = vim.api.nvim_get_current_win()

  -- Run the original toggle command.
  vim.cmd.UndotreeToggle()

  local is_now_open = is_undotree_open()

  -- If the window was just opened, force focus back to our starting window.
  -- This is much more reliable than `wincmd p`.
  if not was_open and is_now_open then
    vim.api.nvim_set_current_win(original_win)
  end
end

--- The intelligent function for your <A-u> keymap.
---   - If undotree is open, it focuses the main tree panel.
---   - If undotree is NOT open, it opens it AND focuses the main tree panel.
local function smart_focus_or_toggle_undotree()
  if is_undotree_open() then
    -- It's already open, so just focus the main tree panel.
    vim.cmd.UndotreeFocus()
  else
    -- It's not open, so open it...
    vim.cmd.UndotreeToggle()
    -- ...and then immediately force focus to the main tree panel.
    vim.cmd.UndotreeFocus()
  end
end

-- ===================================================================
--                        YOUR KEYMAPS
-- ===================================================================

-- Your <leader>uu keymap, now pointing to the reliable "no focus steal" function.
vim.keymap.set("n", "<leader>uu", toggle_undotree_no_focus_steal, { desc = "Toggle Undotree (Keep Focus)" })

-- Your intelligent <A-u> keymap.
vim.keymap.set("n", "<A-u>", smart_focus_or_toggle_undotree, { desc = "Focus or Toggle Undotree" })



vim.g.undotree_SplitWidth = 40
vim.g.undotree_DiffpanelHeight = 15

-- Do not switch focus to the undotree window when it is toggled open.
-- vim.g.undotree_SetFocusWhenToggle = 1





--- wow this is so cool you can kinda draw images in text adompt this 
---
---
--- " Window layout
-- " style 1
-- " +----------+------------------------+
-- " |          |                        |
-- " |          |                        |
-- " | undotree |                        |
-- " |          |                        |
-- " |          |                        |
-- " +----------+                        |
-- " |          |                        |
-- " |   diff   |                        |
-- " |          |                        |
-- " +----------+------------------------+
-- " Style 2
-- " +----------+------------------------+
-- " |          |                        |
-- " |          |                        |
-- " | undotree |                        |
-- " |          |                        |
-- " |          |                        |
-- " +----------+------------------------+
-- " |                                   |
-- " |   diff                            |
-- " |                                   |
-- " +-----------------------------------+
-- " Style 3
-- " +------------------------+----------+
-- " |                        |          |
-- " |                        |          |
-- " |                        | undotree |
-- " |                        |          |
-- " |                        |          |
-- " |                        +----------+
-- " |                        |          |
-- " |                        |   diff   |
-- " |                        |          |
-- " +------------------------+----------+
-- " Style 4
-- " +-----------------------++----------+
-- " |                        |          |
-- " |                        |          |
-- " |                        | undotree |
-- " |                        |          |
-- " |                        |          |
-- " +------------------------+----------+
-- " |                                   |
-- " |                            diff   |
-- " |                                   |
-- " +-----------------------------------+
