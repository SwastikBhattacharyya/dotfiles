return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		if vim.g.neovide then
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = false,
			})
		else
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = true,
			})
		end
		vim.cmd("colorscheme gruvbox")
	end,
}
