-- vim.opt.colorcolumn = "80"
vim.opt.relativenumber = true

vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#282c34", nocombine = true })
-- vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", nocombine = true })

vim.api.nvim_set_hl(0, "StatusLine", { bg = "#1e2326" })
vim.deprecate = function() end





-- Git Commands
vim.api.nvim_create_user_command("SignedCommit", function(opts)
  local msg = opts.args
  if msg == nil or msg == "" then
    print("Error: Commit message cannot be empty.")
    return
  end

  vim.cmd("split | resize 15 | terminal git commit -m '" .. msg .. "'")
end, {
  nargs = "+",
  desc = "Create a signed commit with the provided message",
})

vim.api.nvim_create_user_command("PushToGithub", function(opts)
  local args = opts.fargs

  if #args == 0 then
    -- No branch provided → normal push
    vim.cmd("split | resize 15 | terminal git push")
    return
  end

  if #args == 1 then
    local branch = args[0] or args[1] or args
    vim.cmd("split | resize 15 | terminal git push --set-upstream origin " .. branch)
    return
  end

  print("Error: Too many arguments. Provide zero or one branch name.")
end, {
  nargs = "*",
  desc = "Push normally or set upstream when branch is given",
})






-- DiffViewer
vim.api.nvim_create_user_command("DiffView", function(opts)
  local target = opts.args ~= "" and opts.args or "HEAD"
  -- Use diff2_horizontal to hide file panel and show ONLY the two diff windows
  vim.cmd("DiffviewOpen " .. target .. " --imply-local --view diff2_horizontal")
end, {
  nargs = "?",
  desc = "Open Diffview with optional ref (no side panel)"
})

vim.api.nvim_create_user_command("DiffExit", function()
  vim.cmd("DiffviewClose")
end, { desc = "Exit Diffview" })






-- CollapseJinja: collapse Jinja template blocks by removing whitespace/newlines
vim.api.nvim_create_user_command("CollapseJinja", function()
  local start_line, end_line

  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "" then
    start_line = vim.fn.getpos("'<")[2]
    end_line = vim.fn.getpos("'>")[2]
  else
    start_line = 1
    end_line = vim.fn.line("$")
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local text = table.concat(lines, " ")

  text = text
      :gsub("{%%", "{%%")
      :gsub("%%}", "%%}")
      :gsub("{{", "{{")
      :gsub("}}", "}}")
      :gsub("%s+", " ")
      :gsub("%s*{%%", "{%%")
      :gsub("%%}%s*", "%%}")
      :gsub("%s*{{", "{{")
      :gsub("}}%s*", "}}")

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, { text })
end, { desc = "Collapse Jinja template into one line" })
