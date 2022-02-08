local api = vim.api;

require('flterm').setup({
        border = 'rounded';
});
api.nvim_set_keymap('n','<C-t>','<Cmd>FlTermToggle<CR>',{noremap = true});
api.nvim_set_keymap('t','<C-t>','<Cmd>FlTermToggle<CR>',{noremap = true});

