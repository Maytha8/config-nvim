require('telescope').setup({})

vim.keymap.set("n", "<leader>of", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>og", require("telescope.builtin").git_files)
vim.keymap.set("n", "<leader>os", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<leader>ol", require("telescope.builtin").live_grep)
