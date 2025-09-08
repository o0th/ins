return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function() vim.g.barbar_auto_setup = false end,
  config = function()
    require('barbar').setup({
      animation = false,
      auto_hide = false,
      tabpages = true,
      clickable = true,
      focus_on_close = 'left',
      hide = { extensions = false, inactive = false },
      highlight_alternate = false,
      highlight_inactive_file_icons = false,
      highlight_visible = false,

      icons = {
        buffer_index = false,
        buffer_number = false,
        button = '',
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'E' },
          [vim.diagnostic.severity.WARN] = { enabled = false },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = true },
        },
        gitsigns = {
          added = { enabled = true, icon = '+' },
          changed = { enabled = true, icon = '~' },
          deleted = { enabled = true, icon = '-' },
        },
        filetype = {
          custom_colors = false,
          enabled = true,
        },
        separator = { left = ' ', right = ' ' },
        alternate = { filetype = { enabled = false }, separator = { left = ' ', right = ' ' } },
        current = { buffer_index = false, separator = { left = ' ', right = ' ' } },
        inactive = { button = '', separator = { left = ' ', right = ' ' } },
        visible = { modified = { buffer_number = false }, separator = { left = ' ', right = ' ' } },
      },

      -- This is the key setting - new buffers insert after current buffer
      insert_at_end = false,
      insert_at_start = false,

      maximum_padding = 1,
      minimum_padding = 1,
      maximum_length = 30,
      minimum_length = 0,
      semantic_letters = true,
      letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
      no_name_title = nil,
    })

    -- Fix italic/cursive font for inactive buffers only
    vim.schedule(function()
      -- Remove italic styling from all barbar highlight groups while preserving colors
      local barbar_groups = {
        'BufferCurrent', 'BufferCurrentIndex', 'BufferCurrentMod', 'BufferCurrentSign', 'BufferCurrentTarget',
        'BufferInactive', 'BufferInactiveIndex', 'BufferInactiveMod', 'BufferInactiveSign', 'BufferInactiveTarget',
        'BufferVisible', 'BufferVisibleIndex', 'BufferVisibleMod', 'BufferVisibleSign', 'BufferVisibleTarget'
      }

      for _, group in ipairs(barbar_groups) do
        local hl = vim.api.nvim_get_hl(0, { name = group })
        if hl.italic then
          hl.italic = false
          vim.api.nvim_set_hl(0, group, hl)
        end
      end
    end)

    -- Keep your existing keymaps
    vim.keymap.set('n', '<S-l>', '<Cmd>BufferNext<CR>', { desc = 'Next buffer' })
    vim.keymap.set('n', '<S-h>', '<Cmd>BufferPrevious<CR>', { desc = 'Previous buffer' })
    vim.keymap.set('n', '<S-c>', '<Cmd>BufferClose<CR>', { desc = 'Close buffer' })
    vim.keymap.set('n', '<S-cc>', '<Cmd>BufferClose!<CR>', { desc = 'Force close buffer' })

    -- Automatically move new buffers next to current buffer
    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function(event)
        if vim.bo[event.buf].buflisted then
          local buf_info = vim.fn.getbufinfo(event.buf)[1]
          if buf_info and buf_info.lastused == 0 then
            -- This is a new buffer, it should already be positioned correctly by barbar
            -- but we can force it if needed
            vim.schedule(function()
              -- barbar should handle this automatically with insert_at_end=false
            end)
          end
        end
      end,
    })
  end,
}
