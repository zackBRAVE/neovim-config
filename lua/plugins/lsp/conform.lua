-- import conform plugin safely
local setup, conform = pcall(require, "conform")
if not setup then
	return
end

-- configure conform
conform.setup({
	-- setup formatters
	formatters_by_ft = {
		json = { "prettier" },
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		markdown = { "prettier" },
	},
	-- format on save
	format_on_save = function(bufnr)
		-- disable format on save for some filetypes
		local ignored_filetypes = {
			"python",
		}
		if vim.tbl_contains(ignored_filetypes, vim.bo[bufnr].filetype) then
			return
		end

		-- format with conform
		require("conform").format({
			bufnr = bufnr,
			timeout_ms = 5000,
		})
	end,
})
