--local g = vim.g;
local fn = vim.fn;
local cmd = vim.cmd;

fn['pum#set_option']({
        border = 'rounded';
        highlight_normal_menu = 'LocalFloating';
        highlight_selected = 'LocalSelected';
});

cmd([[
autocmd CursorMovedI * call pum#close()
]])
