return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "",
					package_pending = "",
					package_uninstalled = "",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"bashls",
				"clangd",
				"cmake",
				"cssls",
				"tailwindcss",
				"dockerls",
				"emmet_language_server",
				"html",
				"jdtls",
				"prismals",
				"ts_ls",
				"jsonls",
				"lua_ls",
				"markdown_oxide",
				"pylsp",
				"rust_analyzer",
				"hydra_lsp",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"shellcheck",
				"cpplint",
				"cmakelint",
				"stylelint",
				"hadolint",
				"htmlhint",
				"checkstyle",
				"oxlint",
				"jsonlint",
				"luacheck",
				"pylint",
				"sqlfluff",
				"yamllint",
			},
		})
	end,
}
