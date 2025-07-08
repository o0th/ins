return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
  },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      lua_ls = {},
      gopls = {}
    },
  },
  config = function(_, opts)
    require("lsp_lines").setup()
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end

    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = {
        only_current_line = false,
      },
      signs = true,
      underline = true,
    })

    local buffer_autoformat = function(bufnr)
      local group = 'lsp_autoformat'
      vim.api.nvim_create_augroup(group, { clear = false })
      vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        group = group,
        desc = 'LSP format on save',
        callback = function()
          -- note: do not enable async formatting
          vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end,
      })
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = id and vim.lsp.get_client_by_id(id)
        if client == nil then
          return
        end

        if client.supports_method(client, 'textDocument/formatting') then
          buffer_autoformat(event.buf)
        end
      end
    })
  end
}
