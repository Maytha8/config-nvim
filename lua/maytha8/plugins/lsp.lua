return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'folke/neodev.nvim',
			{
				'hrsh7th/nvim-cmp',
				dependencies = {
					'L3MON4D3/LuaSnip',
					'saadparwaiz1/cmp_luasnip',
					'hrsh7th/cmp-nvim-lsp',
					'rafamadriz/friendly-snippets',
					'windwp/nvim-autopairs',
				},
			},
			'mhartington/formatter.nvim',
			'mfussenegger/nvim-lint',
		},
	},
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'nvim-treesitter/nvim-treesitter-context', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
	{ 'windwp/nvim-ts-autotag', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
}
