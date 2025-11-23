-- vim.opt.colorcolumn = "80"
vim.opt.relativenumber = true

vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#282c34", nocombine = true })
-- vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", nocombine = true })

vim.api.nvim_set_hl(0, "StatusLine", { bg = "#1e2326" })
vim.deprecate = function() end
