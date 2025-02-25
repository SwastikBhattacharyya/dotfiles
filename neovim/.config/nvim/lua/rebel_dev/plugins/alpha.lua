return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- set header
		dashboard.section.header.val = {
			" _____                                                           _____ ",
			"( ___ )                                                         ( ___ )",
			" |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   | ",
			" |   | ██████╗ ███████╗██████╗ ███████╗████████╗ █████╗ ██████╗  |   | ",
			" |   | ██╔══██╗██╔════╝██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔══██╗ |   | ",
			" |   | ██████╔╝█████╗  ██║  ██║███████╗   ██║   ███████║██████╔╝ |   | ",
			" |   | ██╔══██╗██╔══╝  ██║  ██║╚════██║   ██║   ██╔══██║██╔══██╗ |   | ",
			" |   | ██║  ██║███████╗██████╔╝███████║   ██║   ██║  ██║██║  ██║ |   | ",
			" |   | ╚═╝  ╚═╝╚══════╝╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ |   | ",
			" |   |                                                           |   | ",
			" |   |             ███╗   ██╗██╗   ██╗██╗███╗   ███╗             |   | ",
			" |   |             ████╗  ██║██║   ██║██║████╗ ████║             |   | ",
			" |   |             ██╔██╗ ██║██║   ██║██║██╔████╔██║             |   | ",
			" |   |             ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║             |   | ",
			" |   |             ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║             |   | ",
			" |   |             ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝             |   | ",
			" |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___| ",
			"(_____)                                                         (_____)",
		}

		-- set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>Neotree float<CR>"),
			dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR"),
			dashboard.button("SPC wr", "󰁯  > Restore Session for Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", "󰅙  > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
