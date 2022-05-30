--local g = vim.g;
local fn = vim.fn;

local option = {
        border = 'rounded';
        highlight_selected = 'PmenuSel'
}

local changeHighlighSelected = function ()
        if vim.g.colors_name == 'nord' then
                option.highlight_selected = 'Visual';
        else
                option.highlight_selected = 'PmenuSel';
        end
        fn['pum#set_option'](option);
end

vim.api.nvim_create_autocmd(
        {'ColorScheme'},
        {
                pattern = {'*'},
                callback = changeHighlighSelected;
        }
);



fn['pum#set_option'](option);
