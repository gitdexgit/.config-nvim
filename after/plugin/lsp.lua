-- ~/.config/nvim/lua/user/lsp.lua

-- print("--- LOADING LSP CONFIG ---")

-- This is the core setup for your LSP configuration.
-- It should be called after your LSP-related plugins have been loaded.

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local navic = require("nvim-navic")
local navbundy = require("nvim-navbuddy")

-- This function gets called for every language server that attaches to a buffer
local on_attach = function(client, bufnr)
    -- Enable nvim-navic for this buffer
    navic.attach(client, bufnr)



    -- This is the recommended place to set LSP-specific keymaps
    local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true, desc = 'LSP: ' .. desc })
    end

    -- Keymaps for LSP features. Feel free to uncomment and customize.
    map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
    map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- For more advanced LSP keymaps, you may want to use a plugin like which-key.nvim
    -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
end

-- Add this before cmp.setup()
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load() -- or .load() for eager loading
luasnip.config.setup({})

-- Setup for nvim-cmp, the completion engine
cmp.setup({
    snippet = {
        -- This is the official snippet integration for nvim-cmp
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    -- These are the sources nvim-cmp will use for suggestions
    sources = cmp.config.sources({
        -- { name = "copilot", group_index = 2 }, -- IMPORTANT: Uncomment this ONLY if you have the Copilot plugin
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        {name = "lazydev",
        group_index = 0,
        },
    },
        {
            { name = 'buffer' },
            { name = "path"},
        }
    )
}
)

-- Setup for vim diagnostics (the little icons and popups that show errors)
vim.diagnostic.config({
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- Setup for fidget, the LSP progress indicator
require("fidget").setup({})

-- Setup for mason, the LSP installer
require("mason").setup({
    path = "prepend",
})

-- Setup for mason-lspconfig, which connects mason to the lspconfig plugin
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup({
    -- This ensures your servers are installed
    ensure_installed = {
        "lua_ls", "pyright",
    },
    -- This is the single source of truth for setting up servers.
    handlers = {
        -- This is the default handler for all servers.
        -- It guarantees your on_attach is used for pyright, rust_analyzer, etc.
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = lsp_capabilities,
                on_attach = on_attach, 
            })
        end,
        -- Special override for lua_ls to add custom settings
        ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
                capabilities = lsp_capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = { diagnostics = { globals = { 'vim' } } }
                }
            })
        end,
        -- *** NEW: Manual setup for clangd using system path ***
        ["clangd"] = function()
            -- By providing cmd and filetypes directly, we bypass Mason's search
            -- The 'cmd' will search for 'clangd' in your system's $PATH
            require("lspconfig").clangd.setup({
                capabilities = lsp_capabilities,
                on_attach = on_attach,
                cmd = { "clangd" }, -- Tells lspconfig to execute the system binary
                filetypes = { "c", "cpp", "objc", "objcpp" },
            })
        end,
    }
})


require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
    },
})

