-- import nvim-lint plugin safely
local setup, lint = pcall(require, "lint")
if not setup then
	return
end

-- configure nvim-lint
lint.linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}

-- run linters on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
