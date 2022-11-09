-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- command and undo
keymap.set("", "h", ":", { noremap = true })
keymap.set("", "U", "<C-r>", { noremap = true })

if not vim.g.vscode then
	-- save and quit
	keymap.set("", "Q", ":q<CR>", { noremap = true })
	keymap.set("", "<C-q>", ":qa<CR>", { noremap = true })
	keymap.set("", "S", ":w<CR>", { noremap = true })
	keymap.set("", "S", ":w!<CR>", { noremap = true })
	keymap.set("", "<C-s>", ":w suda://%<CR>", { noremap = true })
	keymap.set("", "<C-q>", ":q!<CR>", { noremap = true })
end

-- search
keymap.set("", "-", "N", { noremap = true })
if vim.g.vscode then
	keymap.set("", "m", "N", { noremap = true })
else
	keymap.set("", "=", "n", { noremap = true })
	keymap.set("", "m", "N", { noremap = true })
end

keymap.set("", "<LEADER><CR>", ":nohlsearch<CR>", { noremap = true })

-- copy paste
keymap.set("n", "Y", "y$", { noremap = true })
keymap.set("v", "Y", '"+y', { noremap = true })

-- indentation
keymap.set("n", "<", "<<", { noremap = true })
keymap.set("n", ">", ">>", { noremap = true })

-- cursor movement
keymap.set("", "j", "h", { noremap = true, silent = true })
keymap.set("", "k", "j", { noremap = true, silent = true })
keymap.set("", "l", "k", { noremap = true, silent = true })
keymap.set("", ";", "l", { noremap = true, silent = true })

keymap.set("", "gl", "gk", { noremap = true, silent = true })
keymap.set("", "gk", "gj", { noremap = true, silent = true })

keymap.set("", "L", "5k", { noremap = true, silent = true })
keymap.set("", "K", "5j", { noremap = true, silent = true })
keymap.set("", "W", "5w", { noremap = true, silent = true })
keymap.set("", "B", "5b", { noremap = true, silent = true })
keymap.set("", "N", "0", { noremap = true, silent = true })
keymap.set("", "M", "$", { noremap = true, silent = true })

keymap.set("", "<LEADER>o", "o<Esc>l", { noremap = true })
keymap.set("", "<LEADER>O", "O<Esc>k", { noremap = true })

if not vim.g.vscode then
	-- window management
	-- split window
	keymap.set("", "<LEADER>sl", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", { noremap = true })
	keymap.set("", "<LEADER>sk", ":set splitbelow<CR>:split<CR>", { noremap = true })
	keymap.set("", "<LEADER>sj", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", { noremap = true })
	keymap.set("", "<LEADER>s;", ":set splitright<CR>:vsplit<CR>", { noremap = true })

	-- move cursor around windows
	keymap.set("", "<LEADER>w", "<C-w>w", { noremap = true })
	keymap.set("", "<LEADER>l", "<C-w>k", { noremap = true })
	keymap.set("", "<LEADER>k", "<C-w>j", { noremap = true })
	keymap.set("", "<LEADER>j", "<C-w>h", { noremap = true })
	keymap.set("", "<LEADER>;", "<C-w>l", { noremap = true })

	-- resize window
	keymap.set("", "<LEADER><up>", ":res +5<CR>", { noremap = true })
	keymap.set("", "<LEADER><down>", ":res -5<CR>", { noremap = true })
	keymap.set("", "<LEADER><left>", ":vertical -5<CR>", { noremap = true })
	keymap.set("", "<LEADER><right>", ":vertical +5<CR>", { noremap = true })

	-- move window position
	keymap.set("", "<LEADER>sh", "<C-w>t<C-w>K", { noremap = true })
	keymap.set("", "<LEADER>sv", "<C-w>t<C-w>H", { noremap = true })

	-- close window below
	keymap.set("", "<LEADER>q", "<C-w>j:q<CR>", { noremap = true })
end

-- move next character to the end of the line
keymap.set("i", "<C-;>", "<Esc>lx$p", { noremap = true })
keymap.set("", "\\s", ":%s//g<left><left>", { noremap = true })

-- keymap.set('', '', '', { noremap = true })
