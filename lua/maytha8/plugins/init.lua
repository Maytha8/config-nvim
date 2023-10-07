return {
	'lewis6991/gitsigns.nvim',
	'nvim-lualine/lualine.nvim',
	{
		'akinsho/bufferline.nvim',
		version = '*',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},
	'lukas-reineke/indent-blankline.nvim',

	'mbbill/undotree',
	{ 'kristijanhusak/vim-dadbod-ui', dependencies = { 'tpope/vim-dadbod' } },
	{ 'saecki/crates.nvim', tag = 'v0.4.0', dependencies = { 'nvim-lua/plenary.nvim' } },
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.3',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
			},
		},
	},
	'preservim/tagbar',
	{
		'nvim-neo-tree/neo-tree.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
	},

	{
		'ThePrimeagen/harpoon',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},

	'karb94/neoscroll.nvim',
	'numToStr/Comment.nvim',
	'lambdalisue/suda.vim',
	'famiu/bufdelete.nvim',
	-- 'ThePrimeagen/vim-be-good',
	'mcookly/bidi.nvim',
	'jamessan/vim-gnupg',
}
