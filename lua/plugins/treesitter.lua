-- Neovim 0.12+ uses built-in vim.treesitter for highlighting.
-- The nvim-treesitter `main` branch (rewrite) installs parsers/queries
-- via :TSInstall / :TSUpdate. The highlighter itself is built-in but
-- needs to be explicitly started per filetype.
local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
	return
end

ts.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Auto-attach the built-in treesitter highlighter for common filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"json", "javascript", "typescript", "tsx", "yaml", "html", "css",
		"markdown", "svelte", "graphql", "bash", "sh", "lua", "vim",
		"dockerfile", "gitignore", "c", "cpp",
	},
	callback = function()
		vim.treesitter.start()
	end,
})
