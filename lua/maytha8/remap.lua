-- Window resizing
vim.keymap.set("n", "<leader>wj", "<c-w>5-")
vim.keymap.set("n", "<leader>wk", "<c-w>5+")
vim.keymap.set("n", "<leader>wh", "<c-w>5<")
vim.keymap.set("n", "<leader>wl", "<c-w>5>")

-- Split screen
vim.keymap.set("n", "<leader>\\", ":vs<cr>")
vim.keymap.set("n", "<leader>/", ":split<cr>")

-- Saving
vim.keymap.set("n", "<c-s>", ":w!<cr>")
vim.keymap.set("n", "<leader>s", ":SudaWrite<cr>")

-- Exiting
vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>Q", ":q!<cr>")
vim.keymap.set("n", "<c-q>", ":qa<cr>")
vim.keymap.set("n", "<c-z>", ":qa!<cr>")

-- Config shortcuts
local config = vim.fn.stdpath('config')
vim.keymap.set('n', '<leader>0', function()
	vim.cmd.edit(config)
end)

-- Select all text
-- vim.keymap.set("n", "<c-a>", "ggVG")

-- Toggle tagbar
vim.keymap.set("n", "<leader>t", ":TagbarToggle<cr>")

-- Scrolling
-- vim.keymap.set("n", "<c-d>", "<c-d>zz")
-- vim.keymap.set("n", "<c-u>", "<c-u>zz")
