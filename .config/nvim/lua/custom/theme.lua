require("catppuccin").setup({
  flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true,
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
