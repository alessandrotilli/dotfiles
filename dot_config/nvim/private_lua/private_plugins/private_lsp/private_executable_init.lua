vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--    vim.keymap.set('n', '<leader>f', function()
--      vim.lsp.buf.format { async = true }
--    end, opts)
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable('eslint')
      vim.lsp.config('eslint', {
      -- require'lspconfig'.eslint.setup {
        capabilities = capabilities
      })

      -- require'lspconfig'.rust_analyzer.setup {
      vim.lsp.enable('rust_analyzer')
      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            check = {
              command = "clippy";
            },
            diagnostics = {
              enable = true;
            }
          }
        }
      })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies =   { 
      'hrsh7th/cmp-nvim-lsp' ,
      'saadparwaiz1/cmp_luasnip' ,
      'L3MON4D3/LuaSnip',
    },

    config = function()
      local cmp = require('cmp')
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end

          -- expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body)
            -- end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
            ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
            -- C-b (back) C-f (forward) for snippet placeholder navigation.
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          }),
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            -- maybe comment out
            { name = 'path' },
            { name = 'buffer' },
          },
        })
      end
    },
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
      config = function()
        require("typescript-tools").setup({
          settings = {
            expose_as_code_action = "all",
          },
        })
      end
    },
    {
      'stevearc/conform.nvim',
      keys = {
        {
          -- Customize or remove this keymap to your liking
          "<leader>f",
          function()
            require("conform").format({ async = true, lsp_fallback = true })
          end,
          mode = "",
          desc = "Format buffer",
        },
      },
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd", "prettier", "eslint_d" },
          typescript = { "prettierd", "prettier", "eslint_d" },
          css = { "prettierd", "prettier" },
          scss = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          json = { "prettierd", "prettier" },
          yaml = { "prettierd", "prettier" },
          graphql = { "prettierd", "prettier" },
          md = { "prettierd", "prettier" },
          txt = { "prettierd", "prettier" },
          rust = { "rustfmt" },
        }
      }
    }
  }

