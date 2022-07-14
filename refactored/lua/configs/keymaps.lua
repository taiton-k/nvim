local nmap = function (lhs, rhs, opts)
        vim.api.nvim_set_keymap('n', lhs, rhs, opts)
end

local imap = function (lhs, rhs, opts)
        vim.api.nvim_set_keymap('i', lhs, rhs, opts)
end

local tmap = function (lhs, rhs, opts)
        vim.api.nvim_set_keymap('t', lhs, rhs, opts)
end

local cmap = function (lhs, rhs, opts)
        vim.api.nvim_set_keymap('c', lhs, rhs, opts)
end

local nnoremap = function (lhs, rhs, opts)
        opts.noremap = true
        nmap(lhs, rhs, opts)
end

local inoremap = function (lhs, rhs, opts)
        opts.noremap = true
        imap(lhs, rhs, opts)
end

local tnoremap = function (lhs, rhs, opts)
        opts.noremap = true
        tmap(lhs, rhs, opts)
end

local cnoremap = function (lhs, rhs, opts)
        opts.noremap = true
        cmap(lhs, rhs, opts)
end



nnoremap("<Leader>a", "ggVG")

nnoremap("j", "gj")
nnoremap("k", "gk")

nnoremap("<Leader>w", "<Cmd>update<CR>")
nnoremap("<Leader>W", "<Cmd>write<CR>")

inoremap("<C-Space>", "<C-[>")
nnoremap("<Esc><Esc>", "<Cmd>set nohlsearch!<CR>")
tnoremap("<Esc><Esc>", "<C-\\><C-N>")

inoremap("<C-b>", "<Esc>ha")
inoremap("<C-f>", "<Esc>la")
imap("<C-p>", "<Esc>ka")
imap("<C-n>", "<Esk>ja")
inoremap("<C-a>", "<Esc>_i")
inoremap("<C-e>", "<Esc>$a")

cnoremap("<C-b>", "<Left>")
cnoremap("<C-f>", "<Right>")
cnoremap("<C-p>", "<Up>")
cnoremap("<C-n>", "<Down>")

inoremap("<C-k>", "<Up>")
