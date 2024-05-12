return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({ 1 })

        require("telescope").load_extension("recent_files")

        local tele = require('telescope.builtin')

        local function git_or_folder_find()
            local success, _ = pcall(tele.git_files)
            if not success then
                tele.find_files({ hidden = true })
            end
        end

        vim.keymap.set("n", "<Leader><Leader>",
            [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
            {noremap = true, silent = true}
        )

        -- search all
        vim.keymap.set('n', '<C-O>', tele.find_files, {}) 

        -- search git files or folder
        vim.keymap.set('n', '<C-o>', git_or_folder_find, {}) 

        -- search grep
        vim.keymap.set('n', '<C-g>', tele.live_grep, {})
        
        -- search word
        vim.keymap.set('n', '<C-f>', function()
            local word = vim.fn.expand("<cword>")
            tele.grep_string({ search = word })
        end)

    end
}

