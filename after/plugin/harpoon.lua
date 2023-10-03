require('harpoon').setup()

vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>y", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<leader>j", require("harpoon.ui").nav_prev)
vim.keymap.set("n", "<leader>k", require("harpoon.ui").nav_next)
for i = 1, 9 do
	vim.keymap.set("n", i .. "<leader>", function()
		require("harpoon.ui").nav_file(i)
	end)
end
