function side_by_side()

  local filetype = vim.bo.filetype


  if filetype == "cpp" then
    vim.notify(filetype, "error")
  end



    -- vim.cmd("wincmd L")
    -- vim.cmd("wincmd H")
  -- end

  -- if filetype == "hpp" or filetype == "h" then
   --  vim.cmd("wincmd L")
 --    vim.cmd("wincmd L")
 -- end

end
vim.cmd('autocmd BufEnter * lua side_by_side()')
