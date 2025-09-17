-- /home/dex/.config/nvim/lua/dex/me.lua

--# this is for the yank visuales when yanking something... it's nice addition 
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 80 }) -- timeout in milliseconds
    end,
})



-- Keymaps for the Quickfix List
vim.keymap.set('n', '<leader>co', '<cmd>copen<cr>', { desc = "Open Quickfix List" })
vim.keymap.set('n', '<leader>sh', '<cmd>:sp<cr>', { desc = "Open Quickfix List" })
vim.keymap.set('n', '<leader>sv', '<cmd>:vsp<cr>', { desc = "Open Quickfix List" })
-- vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = "Next Quickfix Item" })
-- vim.keymap.set('n', '[q', '<cmd>cprev<cr>', { desc = "Previous Quickfix Item" })

-- tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt




--# this is meh but you can like do it manully with like o<esc>{{cc or S}} or
--# just git the vim-impared I guess and learn to use [ and ] better I guess 
-- Open a new, blank, indented line below
-- vim.keymap.set('n', '<leader>oo', function()
--   vim.cmd('put =""')   -- Puts a new blank line below the current one
--   vim.cmd('normal! cc') -- 'cc' clears the line and enters insert mode, respecting indent
-- end, { desc = "Open new line below (no comment/indent)" })
--
-- -- Open a new, blank, indented line above
-- vim.keymap.set('n', '<leader>O', function()
--   vim.cmd('put! =""')  -- Note the '!' to put the line above
--   vim.cmd('normal! cc') -- 'cc' clears the line and enters insert mode, respecting indent
-- end, { desc = "Open new line above (no comment/indent)" })



-- ==============================================================================
-- ==                           Smart Word Wrap                            ==
-- ==============================================================================

-- Function to toggle word wrap and show a notification
function ToggleWrapWithNotification()
  vim.opt.wrap = not vim.opt.wrap:get()

  if vim.opt.wrap:get() then
    vim.notify("Word wrap is ON", vim.log.levels.INFO)
  else
    vim.notify("Word wrap is OFF", vim.log.levels.INFO)
  end
end

-- Keymap to toggle wrap
vim.keymap.set('n', '<leader>W', ToggleWrapWithNotification, { desc = 'Toggle word wrap' })

-- ------------------------------------------------------------------------------
-- -- Motion Overrides for Wrap Mode
-- ------------------------------------------------------------------------------

-- Make j and k move by visual lines when wrap is on.
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move down (wrap aware)" })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move up (wrap aware)" })
vim.keymap.set('v', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move selection down (wrap aware)" })
vim.keymap.set('v', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move selection up (wrap aware)" })

-- Helper function for motions that IGNORE counts (like 0 and ^)
local function create_wrap_aware_motion_no_count(wrap_motion, normal_motion)
  return function()
    local motion = vim.opt.wrap:get() and wrap_motion or normal_motion
    -- We simply feed the motion key itself, with no count.
    vim.api.nvim_feedkeys(motion, 'n', false)
  end
end

-- Helper function for motions that USE counts (like $)
local function create_wrap_aware_motion_with_count(wrap_motion, normal_motion)
  return function()
    -- Get the count; defaults to 1 if none is provided.
    local count = vim.v.count1
    local motion = vim.opt.wrap:get() and wrap_motion or normal_motion
    -- Feed the count and the motion together.
    vim.api.nvim_feedkeys(count .. motion, 'n', false)
  end
end

-- Mappings for Normal, Visual, and Operator-pending modes
-- Use the NO_COUNT helper for 0 and ^
vim.keymap.set({'n', 'v', 'o'}, '0', create_wrap_aware_motion_no_count('g0', '0'), { desc = "Go to screen/line start" })
vim.keymap.set({'n', 'v', 'o'}, '^', create_wrap_aware_motion_no_count('g^', '^'), { desc = "Go to first char of screen/line" })

-- Use the WITH_COUNT helper for $
vim.keymap.set({'n', 'v', 'o'}, '$', create_wrap_aware_motion_with_count('g$', '$'), { desc = "Go to screen/line end" })
--# because for some reaosn <c-i> for me dones't work lol
-- Force <C-i> to behave as the jump forward command
------ OH the problem is from the C-i sends <tab> because idk maybe some plugin in nvim or the terminal itself? i'm not sure
-- vim.keymap.set('n', '<C-i>', '<C-i>', { noremap = true, silent = true, desc = "Jump forward in jump list" })



--- #Trying to make the insert mode kinda like temrinal hehehe 

-- Map Ctrl+f to move the cursor forward (right) in Insert Mode
vim.keymap.set("i", "<C-f>", "<Right>")

-- Map Ctrl+b to move the cursor backward (left) in Insert Mode
        vim.keymap.set("i", "<C-b>", "<Left>")


-- Go to the first non-whitespace character of the line (like ^)
-- Not quite like C-a if I want C-a I just do the like Capslock+a
vim.keymap.set("i", "<C-a>", "<C-o>^")


-- Go to the end of the line (like Ctrl+e in the terminal)
vim.keymap.set("i", "<C-e>", "<End>")


vim.keymap.set('n', '<leader>tt', function()
    vim.fn.system('alacritty --working-directory ' .. vim.fn.expand('%:p:h') .. ' &')
end, { noremap = true, silent = true, desc = "Open Alacritty in current file's directory" })




