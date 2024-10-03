return {
    {'folke/tokyonight.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
    {'nvim-java/nvim-java', opts = {}},
    {'williamboman/mason.nvim', opts = {}},
    {'williamboman/mason-lspconfig.nvim', config = function()
        require('mason-lspconfig').setup({
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end
            }
        })
    end
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lsp_zero = require('lsp-zero')

            local lsp_attach = function(client, bufnr)
                local opts = {buffer = bufnr}
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<leader>ren', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({'n', 'x'}, '<leader>for', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })

        end
    },
    {'hrsh7th/cmp-nvim-lsp'},
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()

            cmp.setup({
                sources = {
                    {name = 'nvim_lsp'},
                },
                mapping = cmp.mapping.preset.insert({
                    -- Navigate between completion items
                    ['<C-k>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
                    ['<C-j>'] = cmp.mapping.select_next_item({behavior = 'select'}),

                    -- `Enter` key to confirm completion
                    ['<CR>'] = cmp.mapping.confirm({select = true}),

                    -- Ctrl+Space to trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Navigate between snippet placeholder
                    ['<C-h>'] = cmp_action.vim_snippet_jump_forward(),
                    ['<C-l>'] = cmp_action.vim_snippet_jump_backward(),

                    -- Scroll up and down in the completion documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end
    },
}
