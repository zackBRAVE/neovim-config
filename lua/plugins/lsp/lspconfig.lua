-- lspconfig is now integrated into vim.lsp.config (Neovim 0.11+)
-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds with LspUI
	keymap.set("n", "gf", "<cmd>LspUI lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>LspUI definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>LspUI code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>LspUI rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>d", "<cmd>LspUI diagnostic<CR>", opts) -- show diagnostics
	keymap.set("n", "[d", "<cmd>LspUI diagnostic prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>LspUI diagnostic next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "<leader>k", "<cmd>LspUI hover<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>i", "<cmd>LspUI outline<CR>", opts) -- see outline on right hand side

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "ts_ls" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("html", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("cssls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("tailwindcss", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("emmet_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

vim.lsp.config("clangd", {})

-- Enable the language servers
vim.lsp.enable({ "ts_ls", "html", "cssls", "tailwindcss", "emmet_ls", "lua_ls", "clangd" })

-- grammarly-languageserver is archived upstream (znck/grammarly, May 2024) and
-- broken on Node 24+ (web-tree-sitter's fetch() can't parse local paths).
-- Explicitly disabled in case mason or another plugin tries to enable it.
vim.lsp.enable("grammarly_ls", false)
