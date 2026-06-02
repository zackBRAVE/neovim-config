-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	use("rlue/vim-barbaric")
	use("bling/vim-bufferline")
	use("bpietravalle/vim-bolt")
	use("qpkorr/vim-renamer")
	use("jacoborus/tender.vim")

	use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("vim-scripts/ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- vs-code like icons
	use("kyazdani42/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use({ "williamboman/mason-lspconfig.nvim", branch = "main" }) -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"jinzhongjia/LspUI.nvim",
		config = function()
			require("LspUI").setup({})
		end,
	})
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("stevearc/conform.nvim") -- configure formatters
	use("mfussenegger/nvim-lint") -- configure linters

	-- treesitter: Neovim 0.12+ uses built-in vim.treesitter for highlighting.
	-- The legacy `master` branch of nvim-treesitter is frozen/incompatible.
	-- The rewritten `main` branch is the supported migration path.
	use({
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		run = ":TSUpdate",
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use("windwp/nvim-ts-autotag") -- autoclose tags (uses built-in vim.treesitter)

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- config completion
	use("folke/neodev.nvim")

	use("lambdalisue/suda.vim")

	use("f-person/auto-dark-mode.nvim")
	use({ "echasnovski/mini.nvim", branch = "stable" })

	use("ellisonleao/gruvbox.nvim")

	use("NLKNguyen/papercolor-theme")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
