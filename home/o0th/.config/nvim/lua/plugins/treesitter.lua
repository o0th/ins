return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local treesitter = require('nvim-treesitter.configs')
    treesitter.setup({
      ensure_installed = {
        'lua',
        'vim',
        'vimdoc',
        'markdown',
        'markdown_inline',
        'go'
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
