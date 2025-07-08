local file_info = function()
  return {
    provider = function()
      return vim.fn.expand('%')
    end,
    hl = { fg = "fg", bg = "bg" },
  }
end

return {
  "rebelot/heirline.nvim",
  dependencies = { "Zeioth/heirline-components.nvim" },
  config = function()
    local heirline = require("heirline")
    local lib = require("heirline-components.all")

    vim.opt.showtabline = 2
    vim.opt.showmode = false
    vim.o.winbar = ""

    -- Setup
    lib.init.subscribe_to_events()
    heirline.load_colors(lib.hl.get_colors())
    heirline.setup({
      tabline = {
        lib.component.tabline_conditional_padding(),
        lib.component.tabline_buffers(),
        lib.component.fill { hl = { bg = "tabline_bg" } },
        lib.component.tabline_tabpages()
      },
      statusline = {
        hl = { fg = "fg", bg = "bg" },
        lib.component.mode(),
        lib.component.git_branch(),
        lib.component.git_diff(),
        file_info(),
        lib.component.fill(),
        lib.component.fill(),
        lib.component.lsp(),
        lib.component.diagnostics(),
        lib.component.treesitter(),
        lib.component.nav(),
        lib.component.mode { surround = { separator = "right" } },
      }
    })

    vim.keymap.set("n", "<s-l>", "<cmd>bnext<cr>", {})
    vim.keymap.set("n", "<s-h>", "<cmd>bprev<cr>", {})
    vim.keymap.set("n", "<s-c>", "<cmd>bd<cr>", {})
  end,
}
