---@diagnostic disable:missing-fields

-- Mason
require('mason').setup({
	ui = {
		icons = {
			package_installed = '✓',
			package_pending = '➜',
			package_uninstalled = '✗',
		},
	},
})

vim.keymap.set('n', '<leader>4', function()
	require('mason.ui').open()
end)

-- Treesitter
require('nvim-treesitter.configs').setup({
	ensure_installed = { 'lua' },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})

require('treesitter-context').setup({ enable = true })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	-- nmap('<leader>f', vim.lsp.buf.format, '[F]ormat')
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
	clangd = {},
	-- gopls = {},
	-- pyright = {},
	rust_analyzer = {},
	tsserver = {},
	html = {},
	-- volar = {},
	-- tailwindcss = {},
	-- svelte = {},

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require('lspconfig')[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require('cmp')
local types = require('cmp.types')

local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		-- ['<C-n>'] = cmp.mapping.select_next_item(),
		-- ['<C-p>'] = cmp.mapping.select_prev_item(),
		-- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
		-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete({}),
		-- ['<CR>'] = cmp.mapping({
		-- 	i = function(fallback)
		-- 		if cmp.visible() and cmp.get_active_entry() then
		-- 			cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
		-- 		else
		-- 			fallback()
		-- 		end
		-- 	end,
		-- 	s = cmp.mapping.confirm({ select = true }),
		-- 	c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		-- }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<Down>'] = {
			i = cmp.mapping.select_next_item({ behaviour = types.cmp.SelectBehavior.Select }),
		},
		['<Up>'] = {
			i = cmp.mapping.select_prev_item({ behaviour = types.cmp.SelectBehavior.Select }),
		},
		['<C-n>'] = {
			i = function()
				if cmp.visible() then
					cmp.select_next_item({ behaviour = types.cmp.SelectBehavior.Insert })
				else
					cmp.complete()
				end
			end,
		},
		['<C-p>'] = {
			i = function()
				if cmp.visible() then
					cmp.select_prev_item({ behaviour = types.cmp.SelectBehavior.Insert })
				else
					cmp.complete()
				end
			end,
		},
		['<C-y>'] = {
			i = cmp.mapping.confirm({ select = false }),
		},
		['<C-e>'] = {
			i = cmp.mapping.abort(),
		},
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete({}),
		['<CR>'] = cmp.mapping.confirm({
			behaviour = types.cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	sources = {
		{
			name = 'nvim_lsp',
			---@diagnostic disable-next-line:unused-local
			entry_filter = function(entry, _ctx)
				local kind = types.lsp.CompletionItemKind[entry:get_kind()]
				if kind == 'Text' then
					return false
				end
				return true
			end,
		},
		{ name = 'luasnip' },
	},
	enabled = function()
		-- disable completion in comments
		local context = require('cmp.config.context')
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == 'c' then
			return true
		else
			return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
		end
	end,
})

-- Formatter
require('formatter').setup({
	filetype = {
		rust = {
			require('formatter.filetypes.rust').rustfmt,
		},
		lua = {
			require('formatter.filetypes.lua').stylua,
		},
		sh = {
			require('formatter.filetypes.sh').shfmt,
		},
		xml = {
			require('formatter.filetypes.xml').tidy,
			-- require('formatter.defaults.prettierd'),
		},
		js = {
			require('formatter.defaults.prettierd'),
		},
		vue = {
			require('formatter.defaults.prettierd'),
		},
		html = {
			require('formatter.filetypes.html').prettierd,
		},
	},
})
vim.cmd([[

command! -nargs=? -range=% -bar
\   -complete=customlist,s:formatter_complete
\   Formatter lua require("formatter.format").format(
\     <q-args>, <q-mods>, <line1>, <line2>)

]])

vim.keymap.set('n', '<leader>f', ':Formatter<cr>')

-- Autopairs
require('nvim-autopairs').setup()

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local ts_utils = require('nvim-treesitter.ts_utils')

local ts_node_func_parens_disabled = {
	-- ecma
	named_imports = true,
	-- rust
	use_declaration = true,
}

local default_handler = cmp_autopairs.filetypes['*']['('].handler
cmp_autopairs.filetypes['*']['('].handler = function(char, item, bufnr, rules, commit_character)
	local node_type = ts_utils.get_node_at_cursor():type()
	if ts_node_func_parens_disabled[node_type] then
		if item.data then
			item.data.funcParensDisabled = true
		else
			char = ''
		end
	end
	default_handler(char, item, bufnr, rules, commit_character)
end

cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done({
		sh = false,
	})
)

-- TS Autotag
require('nvim-ts-autotag').setup()
