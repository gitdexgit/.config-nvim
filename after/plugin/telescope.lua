-- ~/.config/nvim/lua/user/telescope.lua

-- local status_ok, telescope = pcall(require, "telescope")
-- if not status_ok then
--   return
-- end

local Layout = require("nui.layout")
local Popup = require("nui.popup")

local telescope = require("telescope")

--# this doens't work
-- local TSLayout = require("telescope.pickers.layout")

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout") -- We'll need this for new mappings

-- The rest ------------------------------------------------------------------
-- START OF PART 1: TELESCOPE SETUP
------------------------------------------------------------------

-- --- NEW ---
-- RECIPE: Don't preview binary files
-- This requires the `file` command-line tool to be installed.
-- # doesn't work well sadly
-- local previewers = require("telescope.previewers")
-- local Job = require("plenary.job")
-- local new_maker = function(filepath, bufnr, opts)
--   filepath = vim.fn.expand(filepath)
--   Job:new({
--     command = "file",
--     args = { "--mime-type", "-b", filepath },
--     on_exit = function(j)
--       local mime_type = vim.split(j:result()[1], "/")[1]
--       if mime_type == "text" then
--         previewers.buffer_previewer_maker(filepath, bufnr, opts)
--       else
--         -- If it's not text, just show a message.
--         vim.schedule(function()
--           vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
--         end)
--       end
--     end,
--   }):sync()
-- end

-- local function make_popup(options)
--   local popup = Popup(options)
--   function popup.border:change_title(title)
--     popup.border.set_text(popup.border, "top", title)
--   end
--   return TSLayout.Window(popup)
-- end


telescope.setup({
  defaults = {
    layout_strategy = "flex",


    layout_config = {
        -- preview_width = 0.5,
        -- Use 95% width/height. 100% can sometimes cause weird border artifacts.
        width = 0.95,
        height = 0.95,
        -- You can also configure the flex-specific options if you want
        flex = {
            flip_columns = 35,
        }
    },


    -- let's try this for now and later we try it with this on for like full path problem solving
    path_display = { "truncate" },
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    prompt_prefix = "  ",
    selection_caret = " ",
    history = {
      path = vim.fn.stdpath "data" .. "/telescope_history.sqlite3",
      limit = 100,
    },
    vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--trim" },
    preview = { filesize_limit = 5 },

    -- --- NEW ---
    -- Use our binary file checker for all buffer previews
    -- buffer_previewer_maker = new_maker,

    mappings = {
        i = {
            -- Make <esc> close Telescope directly from insert mode
            ["M-q"] = actions.close,
            ["<C-x>"] = actions.select_vertical,
            ["<C-h>"] = actions.select_horizontal,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<M-p>"] = action_layout.toggle_preview,
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
            --#This keys don't exist you get error
            -- ["<C-f>"] = actions.results_scrolling_left,
            -- ["<C-e>"] = actions.results_scrolling_right,
        },
        n = {
            ["q"] = actions.close,
            ["<C-x>"] = actions.select_vertical,
            ["<C-h>"] = actions.select_horizontal,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<M-p>"] = action_layout.toggle_preview,
            ["<Up>"] = actions.cycle_history_prev,
            ["<Down>"] = actions.cycle_history_next,
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
            --#This keys don't exist you get error
            -- ["<C-f>"] = actions.results_scrolling_left,
            -- ["<C-e>"] = actions.results_scrolling_right,
        },
    },
},

pickers = {
    buffers = {
        preview_width = 0.7,
        layout_config = { height = 0.6, width = 0.8 },
        --#this doens't work it's a lie 
        -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        -- theme = "dropdown",
        -- previewer = false,
        mappings = {
            i = { ["<M-d>"] = actions.delete_buffer }, -- Use <c-d> to delete
            n = { ["dd"] = actions.delete_buffer },
        },
    },

    -- --- NEW ---
    -- Add this new entry for the current buffer fuzzy finder
    current_buffer_fuzzy_find = {
      -- Tell it to use a centered dropdown theme without a preview
      -- theme = "dropdown",
      previewer = false,
    },
    find_files = {
      preview_width = 0.3,
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      -- --- NEW ---
      -- RECIPE: Add a mapping in normal mode to change directory
      -- #this is not worth it it's better to do it with after find you do <leader>cwd or do it through the neotree
      -- mappings = {
      --   n = {
      --     ["<leader>cd"] = function(prompt_bufnr)
      --       local selection = require("telescope.actions.state").get_selected_entry()
      --       local dir = vim.fn.fnamemodify(selection.path, ":p:h")
      --       require("telescope.actions").close(prompt_bufnr)
      --       vim.cmd.lcd(dir) -- Use :lcd to change dir for the current window only
      --       vim.notify("Changed CWD to: " .. dir)
      --     end,
      --   },
      -- },
    },
  },
  extensions = {},
})



-- =======================================================
-- PART 2: YOUR PERSONAL KEYMAPS
-- These are the shortcuts to *launch* the different Telescope pickers.
-- =======================================================
local builtin = require('telescope.builtin')
local keymap = vim.keymap.set


--# btw this only searches one line... you can't search for multiple lines... that's umm that's kinda complex
--# even though I can grep_string all the other lines with this... I'll stop from doing that to be honest... I'll only use this
--# for fuzzy find only 1 line and selection text within that line. for multiple lines maybe I need something else like regex or something
local function get_selection_or_cword()
    local mode = vim.fn.mode()
    if mode == 'v' or mode == 'V' or mode == string.char(22) then
        -- Get the start and end of visual selection
        local start_pos = vim.fn.getpos('v')
        local end_pos = vim.fn.getpos('.')
        -- Make sure start comes before end
        if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
            start_pos, end_pos = end_pos, start_pos
        end
        local start_line = start_pos[2]
        local end_line = end_pos[2]
        local start_col = start_pos[3]
        local end_col = end_pos[3]
        -- Get all lines in the selection range
        local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
        if #lines == 0 then
            return ''
        end
        if mode == 'V' then
            -- Line-wise visual mode: take entire lines
            return table.concat(lines, '\n')
        elseif mode == string.char(22) then
            -- Block-wise visual mode: extract column range from each line
            for i = 1, #lines do
                local line = lines[i]
                if start_col > #line then
                    lines[i] = ""
                else
                    local end_idx = math.min(end_col, #line)
                    lines[i] = line:sub(start_col, end_idx)
                end
            end
            return table.concat(lines, '\n')
        else
            -- Character-wise visual mode (v)
            if #lines == 1 then
                -- Single line selection
                return lines[1]:sub(start_col, end_col)
            else
                -- Multi-line selection
                lines[1] = lines[1]:sub(start_col)
                lines[#lines] = lines[#lines]:sub(1, end_col)
                return table.concat(lines, '\n')
            end
        end
    else
        return vim.fn.expand('<cword>')
    end
end

-- Your keymaps, cleaned up and organized:
-- # grown used to ff and pf
-- keymap('n', '<leader>tf', builtin.find_files, { desc = 'Telescope find files' })
-- keymap('n', '<leader>tt', builtin.find_files, { desc = 'Telescope find files' })
-- keymap('n', '<leader>T', builtin.find_files, { desc = 'Telescope find files' })
keymap('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })


keymap('n', '<leader>ff', function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end)
--# pf makes more sense because I have nf which is for neotree so they work kinda the same... 
--so always think of a letter+f if it's p then it's telescrop if it's n then it's neotree
-- keymap('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
--# I'm not sure about the <leaader>F tbh I'm just too used to ff and pf
-- keymap('n', '<leader>F', builtin.find_files, { desc = 'Telescope find files' })

--# idk why prime has C-p umm isn't <leader>gf and <leader>gs better and more optimized ? regardless whatever
--# this finds only files tracked by git so it's useful instead of searching the whole dir which could be bad
--# this one repects the .gitignore too right so you can kinda have filters which is sick but also when you need to ignore
--# the filter you just use pf or ff
-- keymap('n', '<C-p>', builtin.git_files, { desc = 'Telescope find Git files' })
--


--# idk what these are and how to use them and what not .... 
keymap('n', '<leader>Gf', builtin.git_files, { desc = 'Telescope find Git files' })
keymap('n', '<leader>Gs', builtin.git_status, { desc = 'Telescope Git status' })
keymap('n', '<leader>Gb', builtin.git_branches, { desc = 'Telescope Git branches' })
keymap('n', '<leader>Gc', builtin.git_commits, { desc = 'Telescope Git commits' })
keymap('n', '<leader>GS', builtin.git_stash, { desc = 'Telescope Git stash' })
keymap('n', '<leader>GC', builtin.git_bcommits, { desc = 'Telescope Git bcommits' })


keymap('n', '<leader>B', builtin.buffers, { desc = 'Telescope Find buffers' })

-- keymap('n', '<leader>fb', builtin.buffers, { desc = 'Telescope Find buffers' })

keymap('n', '<leader>ts', builtin.lsp_document_symbols, { desc = 'Telescope Document symbols' })
keymap('n', '<leader>tS', builtin.lsp_workspace_symbols, { desc = 'Telescope Workspace symbols' })
keymap('n', '<leader>tw', builtin.lsp_workspace_symbols, { desc = 'Telescope Workspace symbols' })


keymap('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope Find helper' })
keymap('n', '<leader>f?', builtin.builtin, { desc = 'List Telescope built-ins' })
keymap('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope Find keymaps' })

keymap('n', '<leader>tr', builtin.registers, { desc = 'Telescope Paste from register' })
keymap('n', '<leader>R', builtin.registers, { desc = 'Telescope Paste from register' })

keymap('n', '<leader>tj', builtin.jumplist, { desc = 'Telescope Jumplist' })
keymap('n', '<leader>J', builtin.jumplist, { desc = 'Telescope Jumplist' })

keymap('n', '<leader>to', builtin.oldfiles, { desc = 'Telescope Old files' })
keymap('n', '<leader>of', builtin.oldfiles, { desc = 'Telescope Old files' })

keymap('n', '<leader>tc', builtin.commands, { desc = 'Telescope Commands' })
keymap('n', '<leader>C', builtin.commands, { desc = 'Telescope Commands' })

keymap('n', '<leader>th', builtin.command_history, { desc = 'Telescope Commands history' })
keymap('n', '<leader>H', builtin.command_history, { desc = 'Telescope Commands history' })

keymap('n', '<leader>tm', builtin.marks, { desc = 'Telescope Find marks' })
keymap('n', '<leader>M', builtin.marks, { desc = 'Telescope Find marks' })

keymap('n', '<leader>man', builtin.man_pages, { desc = 'Telescope Man pages' })


-- -------------- Search the current buffer or dir for strings ----------------------------
--# search in current buffer on the word with telescope fzf supports selection and no word
vim.keymap.set({'n', 'v'}, '<leader>gs', function()
    local text_to_find = get_selection_or_cword()

    -- If the text is nil or empty, just open Telescope without a prompt
    if not text_to_find or text_to_find == '' then
        builtin.current_buffer_fuzzy_find()
        return
    end

    -- Clean up the text for better fuzzy matching
    text_to_find = text_to_find
        :gsub("\n", " ")           -- Replace newlines with spaces
        :gsub("%s+", " ")          -- Replace multiple spaces with single space
        :gsub("^%s+", "")          -- Trim leading whitespace
        :gsub("%s+$", "")          -- Trim trailing whitespace

    -- Use default_text for an interactive prompt!
    builtin.current_buffer_fuzzy_find({
        default_text = text_to_find,
    })
end, { desc = 'Fuzzy find selection/cword in buffer' })

--# search in folder dir on the word with telescope fzf supports selection and no word
vim.keymap.set({'n', 'v'}, '<leader>gS', function()
    local text_to_find = get_selection_or_cword()

    -- If the text is nil or empty, just open Telescope without a prompt
    if not text_to_find or text_to_find == '' then
        builtin.grep_string({
            default_text = vim.fn.expand('<cword>')
        })
        return
    end

    -- Clean up the text for better fuzzy matching
    text_to_find = text_to_find
        :gsub("\n", " ")           -- Replace newlines with spaces
        :gsub("%s+", " ")          -- Replace multiple spaces with single space
        :gsub("^%s+", "")          -- Trim leading whitespace
        :gsub("%s+$", "")          -- Trim trailing whitespace

    -- Use default_text for an interactive prompt!
    builtin.grep_string({
        default_text = text_to_find,
    })
end, { desc = 'Fuzzy find selection/cword in buffer' })

--# this is one of the classics maybe it could be useful maybe it's not useful i'm not sure but whatever
-- keymap('n', '<leader>gs', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end, { desc = 'Telescope Grep string' })

-- # this one I made but it seems useless and repitiave
-- no need for Mr.Prime's <leader>gs
keymap('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Telescope Fuzzy find in buffer' })


-- this pre-populates the prompt with an empty string.
-- pressing Enter will match and list EVERY line in your project.
-- This can be very slow and is generally not very useful.
keymap('n', '<leader>g/', function()
	require('telescope.builtin').grep_string({ search = "" });
end, { desc = 'Telescope Grep all lines (press Enter)' })


-- This is your modified <leader>gS mapping in PART 2

--# this is g/ but g/ searches all the files but this one searches only files within the directory for the string 
vim.keymap.set({'n', 'v'}, '<leader>G/', function()
    -- --- ADD THIS LINE ---
    local current_dir = vim.fn.expand('%:p:h')

    local text_to_find = get_selection_or_cword()

    if not text_to_find or text_to_find == '' then
        builtin.grep_string({
            default_text = vim.fn.expand('<cword>'),
            -- --- AND ADD THIS LINE ---
            cwd = current_dir,
        })
        return
    end

    text_to_find = text_to_find
        :gsub("\n", " ")
        :gsub("%s+", " ")
        :gsub("^%s+", "")
        :gsub("%s+$", "")

    builtin.grep_string({
        default_text = text_to_find,
        -- --- AND ADD THIS LINE ---
        cwd = current_dir,
    })
end, { desc = 'Fuzzy find selection/cword in CURRENT DIRECTORY' })

-- END-------------- Search the current buffer or dir for strings END----------------------------
