vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])

return {
	"numToStr/FTerm.nvim",
	version = "*",
	dependencies = {
	},
	config = function()
		require('FTerm').setup { {
			border     = 'double',
			dimensions = {
				height = 0.9,
				width = 0.9,
			},
		} }
	end,
}
