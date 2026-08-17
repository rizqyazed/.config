return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{ "nvim-mini/mini.surround", version = false },
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
	},
}
