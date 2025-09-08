require("config.lazy")

vim.cmd.colorscheme("dracula")

vim.opt.clipboard:append("unnamedplus")
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 15
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.switchbuf = "useopen,usetab,newtab"

vim.wo.number = true

vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("v", "y", '"+y', { noremap = true })
vim.keymap.set("x", "p", [["_dP]], { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

-- Add visual padding between tabline and editor
vim.opt.cmdheight = 1

-- Create a custom winbar with padding that matches editor background
local function set_winbar_colors()
  local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
  vim.api.nvim_set_hl(0, 'WinBar', { bg = normal_bg })
  vim.api.nvim_set_hl(0, 'WinBarNC', { bg = normal_bg }) -- Non-current window winbar
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  callback = function()
    set_winbar_colors()
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    -- Only apply to normal file buffers, avoid telescope and other floating windows
    if vim.bo.buftype == "" and vim.bo.filetype ~= "TelescopePrompt" then
      vim.wo.winbar = " " -- Empty space as padding
      set_winbar_colors()
    else
      vim.wo.winbar = nil -- Clear winbar for special buffers
    end
  end,
})
