vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>e", ":Oil<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>ls", ":LivePreview start<CR>")
vim.keymap.set("n", "<leader>lc", ":LivePreview close<CR>")

-- vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
-- 	desc = "Show diagnostic error",
-- })

-- Copy to system clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+yg_')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local opt = {}

vim.diagnostic.config({ virtual_text = true })

vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.undofile = true

require("lazy").setup("plugins")
require("oil").setup({
	columns = {
		"icon",
	},
	float = {
		max_width = 0.7,
		max_height = 0.6,
		border = "rounded",
	},
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
		-- This function defines what is considered a "hidden" file
		is_hidden_file = function(name, bufnr)
			local m = name:match("^%.")
			return m ~= nil
		end,
		-- This function defines what will never be shown, even when `show_hidden` is set
		is_always_hidden = function(name, bufnr)
			return false
		end,
		-- Sort file names with numbers in a more intuitive order for humans.
		-- Can be "fast", true, or false. "fast" will turn it off for large directories.
		natural_order = "fast",
		-- Sort file and directory names case insensitive
		case_insensitive = false,
		sort = {
			-- sort order can be "asc" or "desc"
			-- see :help oil-columns to see which columns are sortable
			{ "type", "asc" },
			{ "name", "asc" },
		},
	},
})
require("vague").setup()
require("mini.surround").setup()
require("lsp_signature").setup()
-- require("nvim-treesitter").setup({
-- 	-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
-- 	install_dir = vim.fn.stdpath("data") .. "/site",
-- })
-- require("nvim-treesitter")
-- 	.install({ "lua", "javascript", "typescript", "tsx", "css", "html", "astro", "json", "yaml" })
-- 	:wait(300000)

-- vim.o.background = "dark"

-- Statusbar - good if you don't want to use a plugin. I stole this from someone on Reddit who got it from someone else I think xD
-- vim.o.statusline = [[%<%f %h%m%r %y%=%{v:register} %-14.(%l,%c%V%) %P]]

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"css",
		"html",
		"astro",
		"lua",
	},
	callback = function(args)
		vim.treesitter.start(args.buf)
	end,
})

vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, { silent = true })

vim.keymap.set({ "n" }, "<Leader>k", function()
	vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = "toggle signature" })

vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#ff5edf", fg = "#ffffff" })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 300 })
	end,
})
