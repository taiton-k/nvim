local nnoremap = function (lhs, rhs, opts)
        vim.keymap.set('n', lhs, rhs, opts)
end

local inoremap = function (lhs, rhs, opts)
        vim.keymap.set('i', lhs, rhs, opts)
end

local tnoremap = function (lhs, rhs, opts)
        vim.keymap.set('t', lhs, rhs, opts)
end

local cnoremap = function (lhs, rhs, opts)
        vim.keymap.set('c', lhs, rhs, opts)
end

local nmap = function (lhs, rhs, opts)
        if opts and opts.noremap then
                opts.noremap = false
        end
        nnoremap(lhs, rhs, opts)
end

local imap = function (lhs, rhs, opts)
        if opts and opts.noremap then
                opts.noremap = false
        end
        inoremap(lhs, rhs, opts)
end

local tmap = function (lhs, rhs, opts)
        if opts and opts.noremap then
                opts.noremap = false
        end
        tnoremap(lhs, rhs, opts)
end

local cmap = function (lhs, rhs, opts)
        if opts and opts.noremap then
                opts.noremap = false
        end
        cnoremap(lhs, rhs, opts)
end



nnoremap("<Leader>a", "ggVG")

nnoremap("j", "gj")
nnoremap("k", "gk")

nnoremap("<Leader>w", "<Cmd>update<CR>")
nnoremap("<Leader>W", "<Cmd>write<CR>")

inoremap("<C-Space>", "<C-[>")
nnoremap("<Esc><Esc>", "<Cmd>set nohlsearch!<CR>")
tnoremap("<Esc><Esc>", "<C-\\><C-N>")

imap("<C-b>", "<Left>")
imap("<C-f>", "<Right>")
imap("<C-p>", "<Up>")
imap("<C-n>", "<Down>")

cmap("<C-b>", "<Left>")
cmap("<C-f>", "<Right>")
cmap("<C-p>", "<Up>")
cmap("<C-n>", "<Down>")

inoremap("<C-a>", "<Esc>_i")
inoremap("<C-e>", "<Esc>$a")

inoremap("<C-k>", "<Up>")
