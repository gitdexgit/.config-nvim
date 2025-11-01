-- /home/dex/.config/nvim/lua/dex/packer.lua 


-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]



return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', branch = 'master',
        -- 'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


    use {
      "nvim-telescope/telescope-file-browser.nvim",
      requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    use {
        'ThePrimeagen/vim-be-good'
    }



    use {
        "debugloop/telescope-undo.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }


    use('petertriho/nvim-scrollbar')

    use {'kevinhwang91/nvim-hlslens'}


    use {
      "ahmedkhalf/project.nvim",
    }

    -- in your packer startup function
    use {
        "folke/lazydev.nvim",
        ft = "lua", -- Only load on lua files
        config = function()
            require("lazydev").setup({
                -- Your options go here
                -- See the configuration section for more details
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    -- You can add other libraries here, like wezterm-types if you use it
                    -- { path = "wezterm-types", mods = { "wezterm" } },
                }
            })
        end
    }


      -- The notification plugin
      use {
        'rcarriga/nvim-notify',
      }


use ({
    "rose-pine/neovim",
    -- lazy = false, -- Load this theme on startup
    -- priority = 1000, -- Make sure it loads before other plugins
    -- name = "rose-pine",
    config = function()
require("rose-pine").setup({
    -- variant = "auto", -- auto, main, moon, or dawn
    -- dark_variant = "moon", -- main, moon, or dawn
    -- dim_inactive_windows = false,
    -- extend_background_behind_borders = true,

    -- enable = {
    --     terminal = true,
    --     legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
    --     migrations = true, -- Handle deprecated options automatically
    -- },

    disable_background = true,
    styles = {
        -- bold = true,
        italic = false,
        -- transparency = false,
    },

    -- groups = {
    --     border = "muted",
    --     link = "iris",
    --     panel = "surface",
    --
    --     error = "love",
    --     hint = "iris",
    --     info = "foam",
    --     note = "pine",
    --     todo = "rose",
    --     warn = "gold",
    --
    --     git_add = "foam",
    --     git_change = "rose",
    --     git_delete = "love",
    --     git_dirty = "rose",
    --     git_ignore = "muted",
    --     git_merge = "iris",
    --     git_rename = "pine",
    --     git_stage = "iris",
    --     git_text = "rose",
    --     git_untracked = "subtle",
    --
    --     h1 = "iris",
    --     h2 = "foam",
    --     h3 = "rose",
    --     h4 = "gold",
    --     h5 = "pine",
    --     h6 = "foam",
    -- },

    -- palette = {
    --     -- This is where we override the core colors for a specific variant.
    --     moon = {
    --         -- 'base' is the main background color.
    --         -- The default for moon is '#232136'.
    --         -- Choose ONE of the lines below and uncomment it.
    --
    --         -- Option A: A slightly darker version of the original Moon background
    --         -- base = '#1c1a2b',
    --
    --         -- Option B: A very dark, neutral gray (less purple)
    --         base = '#121212',
    --
    --         -- Option C: Pure black (great for OLED screens)
    --         -- base = '#000000',
    --     },
    --     -- Override the builtin palette per variant
    --     -- moon = {
    --     --     base = '#18191a',
    --     --     overlay = '#363738',
    --     -- },
    -- },

	-- NOTE: Highlight groups are extended (merged) by default. Disable this
	-- per group via `inherit = false`
    -- highlight_groups = {
    --     -- Comment = { fg = "foam" },
    --     -- StatusLine = { fg = "love", bg = "love", blend = 15 },
    --     -- VertSplit = { fg = "muted", bg = "muted" },
    --     -- Visual = { fg = "base", bg = "text", inherit = false },
    -- },

    -- before_highlight = function(group, highlight, palette)
    --     -- Disable all undercurls
    --     -- if highlight.undercurl then
    --     --     highlight.undercurl = false
    --     -- end
    --     --
    --     -- Change palette colour
    --     -- if highlight.fg == palette.pine then
    --     --     highlight.fg = palette.foam
    --     -- end
    -- end,
})

-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme rose-pine-main")
-- vim.cmd("colorscheme rose-pine-moon")
-- vim.cmd("colorscheme rose-pine-dawn")
    end
})


	-- use {
	-- 	"folke/tokyonight.nvim",
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "moon",
	-- 			transparent = true, -- tokyonight has a built-in option
	-- 			styles = {
	-- 				sidebars = "dark",
	-- 				floats = "dark",
	-- 			},
	-- 		})
	-- 		-- If you wanted to use tokyonight instead, you would call:
	-- 		-- vim.cmd.colorscheme("tokyonight")
	-- 	end
	-- }

    use {"akinsho/toggleterm.nvim", tag = '*'}

use {'kevinhwang91/nvim-bqf', ft = 'qf'}

use {
    "SmiteshP/nvim-navbuddy",
    requires = {
        "neovim/nvim-lspconfig",
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
        "numToStr/Comment.nvim",        -- Optional
        "nvim-telescope/telescope.nvim" -- Optional
    }
}


use ('christoomey/vim-tmux-navigator')
use ('tpope/vim-unimpaired')



use {'tpope/vim-surround'}

    -- in packer.lua
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    })

    -- in packer.lua


-- in packer.lua

-- /home/dex/.config/nvim/lua/dex/packer.lua






-- /home/dex/.config/nvim/lua/dex/packer.lua

-- /home/dex/.config/nvim/lua/dex/packer.lua

-- In /home/dex/.config/nvim/lua/dex/packer.lua

use {
    "folke/snacks.nvim",
    priority = 1000,
    config = function()
        require("snacks").setup({
            -- dashboard = {
                --     enabled = true,
                --     -- V V V ADD THIS NEW 'preset' TABLE V V V
                --     preset = {
                    --         -- Override the default keymaps for the dashboard
                    --         keys = {
                        --             -- This tells the 'f' key to run Telescope's find_files
                        --             { icon = " ", key = "f", desc = "Find File (Telescope)", action = ":Telescope find_files" },
                        --             { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        --             { icon = " ", key = "g", desc = "Find Text (Telescope)", action = ":Telescope live_grep" },
                        --             { icon = " ", key = "r", desc = "Recent Files (Telescope)", action = ":Telescope oldfiles" },
                        --             { icon = " ", key = "c", desc = "Config", action = ":e ~/.config/nvim" },
                        --             { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                        --         },
                        --     },
                        --     -- ^ ^ ^ END OF THE NEW TABLE ^ ^ ^
                        --     sections = {
                            --         { section = "header" },
                            --         { section = "keys", gap = 1, padding = 1 },
                            --         {
                                --             enabled = function()
                                    --                 return vim.fn.finddir('.git', ';') ~= ''
                                    --             end,
                                    --             title = " Git Status",
                                    --             icon = " ",
                                    --             section = "terminal",
                                    --             cmd = "git status --short --branch",
                                    --             height = 5,
                                    --             padding = 1,
                                    --         },
                                    --     },
                                    -- },
                                    -- Visuals
                                    -- indent = { enabled = true },
                                    statuscolumn = { enabled = true },
                                    dim = { enabled = true },
                                    words = { enabled = true },
                                    -- Workflow
                                    zen = { enabled = true },
                                    bigfile = { enabled = true },
                                    rename = { enabled = true },
                                    bufdelete = { enabled = true },
                                    gitbrowse = { enabled = true },
                                    lazygit = { enabled = true },
                                    scratch = { enabled = true },
                                    input = { enabled = true }, -- Make sure this line is present and true
                                })
                            end,
                        }

    use {
        's1n7ax/nvim-window-picker',
        config = function()
            require('window-picker').setup({
                -- This sets the style you want
                hint = 'floating-big-letter',

                -- Add this section to change what windows are ignored
                filter_rules = {
                    bo = {
                        -- By default, this list includes 'neo-tree'.
                        -- We are giving it a new list that doesn't have it.
                        filetype = { 'NvimTree', 'notify', 'snacks_notif', 'packer' },
                    }
                }
            })
        end,
    }


    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }


    use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
    }

    use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use('nvim-treesitter/playground')

    use('ThePrimeagen/harpoon')

    use('mbbill/undotree')

    use("folke/trouble.nvim")

    use('tpope/vim-fugitive')

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                -- This ensures the signs appear automatically
                signcolumn = true,
                numhl = false, -- Let snacks.statuscolumn handle the line number highlighting
                linehl = false,
                word_diff = false,
                -- This is just a nice-to-have, it lets you see the deleted lines
                -- in a little popup when you are on a modified line.
                on_attach = function(bufnr)
                    vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk,
                        { buffer = bufnr, desc = 'Git: Preview Hunk' })
                end
            })
        end
    }

    -- use {
    --     "andrewferrier/jsregexp.nvim",
    --     config = function()
    --         require("jsregexp").setup()
    --     end
    -- }

    use {
        'neovim/nvim-lspconfig', -- The main plugin for LSP configuration
        requires = {
            -- All the dependencies that nvim-lspconfig needs to provide a good experience

            -- For code formatting
            'stevearc/conform.nvim',

            -- For managing LSP servers, formatters, etc.
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- The completion engine
            'hrsh7th/nvim-cmp',

            -- Sources for the completion engine
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',

            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp", -- 👈 This line triggers the build
            },
            -- A completion source for snippets
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            -- A UI plugin to show LSP status
            'j-hui/fidget.nvim',
        },
    }
end)



