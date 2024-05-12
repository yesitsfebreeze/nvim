return {

    {
        "owickstrom/vim-colors-paramount",
        name = "poimandres",
        config = function()
            require('poimandres').setup({
              bold_vert_split = false,
              dim_nc_background = true,
              disable_background = true,
              disable_float_background = true,
              disable_italics = true,
            })

            vim.cmd("colorscheme poimandres")

            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    },


}
