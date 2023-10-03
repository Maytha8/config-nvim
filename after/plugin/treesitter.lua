require('nvim-treesitter.configs').setup({
	ensure_installed = { 'lua' },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})

require('treesitter-context').setup({ enable = true })
