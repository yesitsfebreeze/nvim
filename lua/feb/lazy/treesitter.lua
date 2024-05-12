return {
    "nvim-treesitter/nvim-treesitter",
    "HiPhish/nvim-ts-rainbow2",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "vimdoc", "cpp", "c", "rust", "jsdoc", "bash",
                -- "all" could be a thing i want?
            },
	    rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    -- disable = { 'jsx', 'cpp' }, 
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
  	   },
           sync_install = false,

            auto_install = true,

            indent = {
                enable = true
            },

            highlight = {
                enable = true,

                additional_vim_regex_highlighting = { "markdown" },
            },
        })

        local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        treesitter_parser_config.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = {"src/parser.c", "src/scanner.c"},
                branch = "master",
            },
        }

        vim.treesitter.language.register("templ", "templ")
    end
}
