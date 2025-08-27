vim.keymap.set("n", "<leader>e", ':Neotree<CR>')
vim.keymap.set("n", "<leader>w", ':w<CR>')
vim.keymap.set("n", "<leader>q", ':q<CR>')
vim.keymap.set("n", "<F5>", ":!(make run)<CR> | !<Esc>:lua vim.notify('Done')<CR>")

-- terminal
vim.keymap.set("n", "<leader>tv", ":vs<CR>:tab term<CR>")
vim.keymap.set("n", "<leader>th", ":split<CR>:tab term<CR>")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
--vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', 'gF', ":vsplit | lua vim.lsp.buf.definition()<CR><C-w>x> | <Esc>:lua vim.notify('Opened in new tab')<CR>")
-- exit terminal mode
vim.keymap.set('t', "<Esc>", "<C-\\><C-n>")
vim.keymap.set('n', '<leader>lf', ':lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<C-j>', "<Esc>:cnext<CR>")
vim.keymap.set('n', '<C-k>', "<Esc>:cprev<CR>")
--disable arrow keys
vim.keymap.set('', '<Up>', '<NOP>')
vim.keymap.set('', '<Down>', '<NOP>')
vim.keymap.set('', '<Left>', '<NOP>')
vim.keymap.set('', '<Right>', '<NOP>')
--jump between buffres
vim.keymap.set('n', '<C-Tab>', "<Esc>:bprev<CR>")
vim.keymap.set('n', '<S-Tab>', "<Esc>:bnext<CR>")

