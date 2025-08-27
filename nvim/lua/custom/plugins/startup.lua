vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])

return {
	"startup-nvim/startup.nvim",
	dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
	config = function()
		require("startup").setup({
			theme = "custom",
			["<leader>fb"]="<cmd>Telescope find_files<CR>"

		})
	end
}
