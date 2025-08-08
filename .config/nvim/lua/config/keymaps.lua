-- keymap for oil plugin
-- It opens the Parent dir in Oil 
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", {desc="Open Parent Directory in Oil"})
local map = vim.keymap.set
local opts = { noremap = true, silent = true  }

-- For scramble
vim.keymap.set("n", "<leader>ss", ":Scramble<CR>", { desc = "Scramble buffer" })
vim.keymap.set("n", "<leader>su", ":Unscramble<CR>", { desc = "Unscramble buffer" })
-- Visual mode
vim.keymap.set("v", "<leader>ss", ":'<,'>Scramble<CR>", { desc = "Scramble selection" })
vim.keymap.set("v", "<leader>su", ":'<,'>Unscramble<CR>", { desc = "Unscramble selection" })

-- H = go to beginning of line
map('n', 'H', '^', opts)
-- L = go to end of line
map('n', 'L', '$', opts)

-- Type ,e   Opens a file with the current working directory already filled in
map('n', ',e', ':e <C-R>=expand("%:p:h") . "/" <CR>', opts)

-- Select all  with Ctrl a
map('n', '<C-a>', 'ggVG$', opts)

-- Allows writing to files with root privileges, w!!
map('c', 'w!!', ':%!sudo tee > /dev/null %', { noremap = true })

-- Insert mode: jj to escape
map('i', 'jj', '<ESC>', opts)
