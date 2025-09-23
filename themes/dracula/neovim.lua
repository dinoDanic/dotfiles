return {
	{
		"Mofiqul/dracula.nvim",
		priority = 1000,
		config = function(_, opts)
			vim.cmd.colorscheme("dracula")
		end,
	},
}
