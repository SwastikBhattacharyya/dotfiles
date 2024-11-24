return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			c = { "cpplint" },
			cmake = { "cmakelint" },
			cpp = { "cpplint" },
			css = { "stylelint" },
			sh = { "shellcheck" },
			dockerfile = { "hadolint" },
			html = { "htmlhint" },
			java = { "checkstyle" },
			javascript = { "oxlint" },
			json = { "jsonlint" },
			lua = { "luacheck" },
			markdown = { "markdownlint" },
			python = { "pylint" },
			sql = { "sqlfluff" },
			yaml = { "yamllint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
