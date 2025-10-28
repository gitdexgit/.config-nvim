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


vim.keymap.set("n", "<leader>uu", toggle_undotree_no_focus_steal, { desc = "Toggle Undotree (Keep Focus)" })

vim.keymap.set("n", "<A-u>", smart_focus_or_toggle_undotree, { desc = "Focus or Toggle Undotree" })



vim.g.undotree_SplitWidth = 40
vim.g.undotree_DiffpanelHeight = 15

-- Do not switch focus to the undotree window when it is toggled open.
-- vim.g.undotree_SetFocusWhenToggle = 1

vim.g.undotree_DisabledFiletypes = { 'TelescopePrompt', 'toggleterm' }




-- _)
-- W40 Mon, 29 at 11:20
-- --START------------------------------------------------------------
-- ""[FAILED] tried to make like switching to diff and what not faster and usier""
-- -------------------------------------------------------------------

-- [[]]

-- DESCRIPTION:

-- Why?:

-- Solution?:

-- --------------------------------------------------------------------


-- ===================================================================
--           NEW: KEYMAPS FOR SWITCHING BETWEEN PANELS
-- ===================================================================

-- --- Finds a window with a specific filetype and focuses it.
-- local function focus_window_by_filetype(target_ft)
--   for _, win in ipairs(vim.api.nvim_list_wins()) do
--     local bufnr = vim.api.nvim_win_get_buf(win)
--     if vim.bo[bufnr].filetype == target_ft then
--       vim.api.nvim_set_current_win(win)
--       return
--     end
--   end
-- end
--
-- -- Create a dedicated group for our autocommands to avoid duplicates
-- local undotree_augroup = vim.api.nvim_create_augroup('UndotreeCustomKeymaps', { clear = true })
--
-- -- When we enter a buffer with the filetype 'undotree'...
-- vim.api.nvim_create_autocmd('FileType', {
--   group = undotree_augroup,
--   pattern = 'undotree',
--   callback = function()
--     -- Create keymaps that are LOCAL to this buffer only.
--     vim.keymap.set('n', '<Tab>', function() focus_window_by_filetype('undotree_diff') end, { buffer = true, desc = "Focus Diff Panel" })
--     vim.keymap.set('n', '<S-Tab>', function() focus_window_by_filetype('undotree') end, { buffer = true, desc = "Focus Tree Panel" })
--   end,
-- })
--
-- -- When we enter a buffer with the filetype 'undotree_diff'...
-- vim.api.nvim_create_autocmd('FileType', {
--   group = undotree_augroup,
--   pattern = 'undotree_diff',
--   callback = function()
--     -- Create keymaps that are LOCAL to this buffer only.
--     vim.keymap.set('n', '<Tab>', function() focus_window_by_filetype('undotree') end, { buffer = true, desc = "Focus Tree Panel" })
--     vim.keymap.set('n', '<S-Tab>', function() focus_window_by_filetype('undotree') end, { buffer = true, desc = "Focus Tree Panel" })
--   end,
-- })
--
--

-- --------------------------------------------------------------------
-- ""[FAILED] tried to make like switching to diff and what not faster and usier""
-- ---END--------------------------------------------------------------

-- _)
-- W40 Mon, 29 at 11:20
-- --START------------------------------------------------------------
-- ""[ADOPT] This way of commenting is sick I want to adopt this drawing on text it's sick""
-- -------------------------------------------------------------------

-- [[]]

-- DESCRIPTION:

-- Why?:

-- Solution?:

-- --------------------------------------------------------------------


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

-- --------------------------------------------------------------------
-- ""[ADOPT] This way of commenting is sick I want to adopt this drawing on text it's sick""
-- ---END--------------------------------------------------------------

