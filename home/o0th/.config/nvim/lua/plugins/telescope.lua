return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope find git files' })
    vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fn', function()
      vim.ui.input({ prompt = 'New file: ' }, function(input)
        if input then vim.cmd('edit ' .. input) end
      end)
    end, { desc = 'Create new file' })

    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "%.git/", "node_modules/" }
      },
      pickers = {
        find_files = { theme = 'ivy', hidden = true },
        git_files = { theme = 'ivy' },
        live_grep = { theme = 'ivy' },
        buffers = { theme = 'ivy' },
        help_tags = { theme = 'ivy' },
      },
    })
  end,
}
