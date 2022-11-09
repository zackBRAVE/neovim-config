if vim.g.vscode then
	vim.opt.clipboard:append("unnamedplus")

	require("packer").startup(function(use)
		use("rlue/vim-barbaric")
	end)

	require("core.keymaps")
else
	require("plugins-setup")
	require("core.options")
	require("plugins.comment")
	require("plugins.nvim-tree")
	require("plugins.lualine")
	require("plugins.telescope")
	require("plugins.nvim-cmp")
	require("plugins.lsp.mason")
	require("plugins.lsp.lspsaga")
	require("plugins.lsp.lspconfig")
	require("plugins.lsp.null-ls")
	require("plugins.autopairs")
	require("plugins.treesitter")
	require("plugins.gitsigns")
	require("plugins.auto-dark-mode")
	require("plugins.papercolor")
	require("core.keymaps")
end
