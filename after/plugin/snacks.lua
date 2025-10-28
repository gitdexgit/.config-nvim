-- This is the single, clean source of truth for your snacks.nvim runtime setup.
-- It runs automatically after all your Packer plugins have been loaded.

-- Safety check to ensure Snacks is available before we try to use it.
local status_ok, Snacks = pcall(require, "snacks")
if not status_ok then
    -- If snacks isn't loaded for some reason, we stop here to avoid errors.
    return
end

-- A single helper function to make setting keymaps cleaner
local map = vim.keymap.set





-- Override vim.print so `:= { my_table = 123 }` uses the pretty inspector
if vim.fn.has("nvim-0.11") == 1 then
    vim._print = function(_, ...) _G.dd(...) end
else
    vim.print = _G.dd
end




map({ "n", "t" }, "g]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Snacks: Next Reference" })
map({ "n", "t" }, "g[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Snacks: Prev Reference" })


-- # this is so nice change from relative number to number really like it 
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ur")
Snacks.toggle.option("number", { name = "Relative Number" }):map("<leader>un")

--# I already have  the <leader>w but I guess naming it <leader>uw is probably better 
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")

--# really fun and interesting kinda like zen but is it useful? I'm not sure but it's there
Snacks.toggle.dim():map("<leader>uD") -- Toggles the dimming effect for focus


--##--- Spelling --------
--# really nice to check English comments? spelling? could be really good for obsidian
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
--###---To use <leader>us well you can pair it with these native nvim stuff:
--# ]s - Jump to the next misspelled word.
--# [s - Jump to the previous misspelled word.
--# z= - This is the most common command. It opens a list of numbered suggestions. Simply type the number of the correct word and press Enter.
--# zg - This tells Vim "this word is good" and adds it to your personal dictionary (g for "good"). The word will no longer be marked as a mistake.
--# Awesome stuff right?
--###---END
--##---END



--# this is really sick to disable and enable diagnostics on the left really sick
Snacks.toggle.diagnostics():map("<leader>ud")

--# really sick ident guides I love them this is what I need 
Snacks.toggle.indent():map("<leader>ui") -- Toggles indent guides

-- ===================================================================
-- 3. Your Chosen Keymaps for Snacks Features
-- ===================================================================
-- These are the keymaps you decided to keep.

-- Grep (as a good backup to Telescope)
map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Snacks: Grep (Live)" })
map({"n", "v"}, "<leader>sG", function() Snacks.picker.grep_word() end, { desc = "Snacks: Grep for Word Under Cursor" })

-- Explorer (as a backup to neo-tree)
map("n", "<leader>se", function() Snacks.explorer() end, { desc = "Snacks: File Explorer" })

-- Zen Mode
map({ "n", "v" }, "<leader>zen", function() Snacks.zen() end, { desc = "Snacks: Toggle Zen Mode" })

-- Scratch Buffers
map("n", "<leader>>", function() Snacks.scratch() end, { desc = "Snacks: Toggle Scratch Buffer" })
map("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Snacks: Select Scratch Buffer" })

-- Buffer Delete
-- This is fine it works well with <Leader>B... it doesn't way just deletes this buffer and even removes it from jump list I believe sick 
map("n", "<leader>bd",function() Snacks.bufdelete() end, { desc = "Snacks: Buffer Delete" })



-- V V V ADD THIS NEW KEYMAP V V V
-- Manually open the dashboard in a float
-- map("n", "<leader>D", function() Snacks.dashboard() end, { desc = "Snacks: Open Dashboard" })
-- ^ ^ ^ END OF THE NEW KEYMAP ^ ^ ^
-- Git Integration


--# just testing which one I like 
map("n", "<leader>GG", function() Snacks.lazygit() end, { desc = "Snacks: Lazygit" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Snacks: Lazygit" })
map("n", "<leader>Lg", function() Snacks.lazygit() end, { desc = "Snacks: Lazygit" })

map({ "n", "v" }, "<leader>GB", function() Snacks.gitbrowse() end, { desc = "Snacks: Git Browse" })
map("n", "<leader>Gl", function() Snacks.picker.git_log() end, { desc = "Snacks: Git Log" })
map("n", "<leader>gl", function() Snacks.git.blame_line() end, { desc = "Git: Blame Line" })
map("n", "<leader>GGb", function() Snacks.picker.git_branches() end, { desc = "Snacks: Git Branches" })
map("n", "<leader>GGs", function() Snacks.picker.git_status() end, { desc = "Snacks: Git Status" })

-- ===================================================================
-- Final Confirmation
-- ===================================================================
-- A small notification to let you know this file was loaded correctly.
-- vim.notify("Snacks.nvim keymaps and setup loaded successfully!", vim.log.levels.INFO, { title = "Snacks" })



-- V V V ADD THIS NEW KEYMAP V V V
map("n", "<leader>fr", function() Snacks.rename.rename_file() end, { desc = "Snacks: Rename File" })
-- ^ ^ ^ END OF THE NEW KEYMAP ^ ^ ^
