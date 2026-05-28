vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])

return {
	"t-troebst/perfanno.nvim",
	version="*",
	dependencies= {
	},
	config = function ()
            local perfanno = require("perfanno")
            local util = require("perfanno.util")

            perfanno.setup {
                -- Creates a 10-step RGB color gradient beween background color and "#CC3300"
                line_highlights = util.make_bg_highlights(nil, "#CC3300", 10),
                vt_highlight = util.make_fg_highlight("#CC3300"),
            }

            local keymap = vim.api.nvim_set_keymap
            local opts = {noremap = true, silent = true}

            keymap("n", "<LEADER>plf", ":PerfLoadFlat<CR>", opts)
            keymap("n", "<LEADER>plg", ":PerfLoadCallGraph<CR>", opts)
            keymap("n", "<LEADER>plo", ":PerfLoadFlameGraph<CR>", opts)

            keymap("n", "<LEADER>pe", ":PerfPickEvent<CR>", opts)

            keymap("n", "<LEADER>pa", ":PerfAnnotate<CR>", opts)
            keymap("n", "<LEADER>pf", ":PerfAnnotateFunction<CR>", opts)
            keymap("v", "<LEADER>pa", ":PerfAnnotateSelection<CR>", opts)

            keymap("n", "<LEADER>pt", ":PerfToggleAnnotations<CR>", opts)

            keymap("n", "<LEADER>ph", ":PerfHottestLines<CR>", opts)
            keymap("n", "<LEADER>ps", ":PerfHottestSymbols<CR>", opts)
            keymap("n", "<LEADER>pc", ":PerfHottestCallersFunction<CR>", opts)
            keymap("v", "<LEADER>pc", ":PerfHottestCallersSelection<CR>", opts)
	end,
}

