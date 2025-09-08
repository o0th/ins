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

    vim.opt.showtabline = 2  -- Keep this for barbar
    vim.opt.showmode = false
    vim.o.winbar = ""

    -- Setup
    lib.init.subscribe_to_events()
    heirline.load_colors(lib.hl.get_colors())

    heirline.setup({
      -- Remove tabline - barbar will handle this
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

    -- Remove the buffer navigation keymaps since barbar will handle them
  end,
}
