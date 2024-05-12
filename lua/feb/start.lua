vim.cmd("vsplit") 



-- -- Define a function to open the counterpart file
-- local function open_source_files()
--   print("test")
--     -- -- Check if the current file is a .cpp file
--     -- if vim.fn.expand("%:e") == "cpp" then
--     --     -- If so, open the corresponding header file on the left
--     --     vim.cmd("vs " .. vim.fn.expand("%:p:r") .. ".hpp")
--     -- -- Check if the current file is a .h file
--     -- elseif vim.fn.expand("%:e") == "h" then
--     --     -- If so, open the corresponding cpp file on the left
--     --     vim.cmd("vs " .. vim.fn.expand("%:p:r") .. ".cpp")
--     -- end
-- end

-- -- Set up an autocmd to trigger the function when opening a cpp or h file
-- vim.cmd([[
--     autocmd BufEnter *.cpp,*.hpp lua open_source_files()
-- ]])