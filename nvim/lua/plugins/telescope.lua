return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						theme = "ivy",
					},
				},
				extensions = {
					fzf = {},
				},
			})
			local builtin = require("telescope.builtin")

			require("telescope").load_extension("fzf")
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({
					find_command = {
						"fd",
						"--type",
						"f",
						"--hidden",
						"--no-ignore",
						"--exclude",
						".git",
						"--exclude",
						"node_modules",
						"--exclude",
						"dist",
						"--exclude",
						"build",
					},
				})
			end, { silent = true })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { silent = true, desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { silent = true, desc = "Telescope live grep" })
			vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions)
		end,
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
