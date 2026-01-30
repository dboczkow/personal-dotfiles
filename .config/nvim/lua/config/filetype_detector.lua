vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("FiletypeDetector", { clear = true }),
  callback = function(args)
    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    for _, line in ipairs(lines) do
      if line:match("^<<<<<<<") or line:match("^=======") or line:match("^>>>>>>>") then
        vim.api.nvim_buf_set_option(args.buf, "filetype", "git-merge-conflict")
        return
      end
    end
  end,
})
