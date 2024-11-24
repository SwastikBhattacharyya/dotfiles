return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				c = { "clang-format" },
				cmake = { "cmake_format" },
				cpp = { "clang-format" },
				css = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				java = { "google-java-format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				sh = { "beautysh" },
				sql = { "sqlfmt" },
				toml = { "taplo" },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		conform.formatters.beautysh = {
			args = {
				"--indent-size",
				"2",
				"$FILENAME",
			},
		}

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
