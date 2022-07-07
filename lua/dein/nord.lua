vim.g.nord_contrast = true;
vim.g.nord_borders = false;
vim.g.nord_disable_background = false;
vim.g.nord_italic = false;

local setHighlight = function (histr) --highlightString
        vim.api.nvim_create_autocmd({'ColorScheme'}, {
                pattern = {'nord'};
                command = 'highlight ' .. histr;
        })
end

-- for transparent
setHighlight('Normal ctermbg=NONE guibg=NONE');
setHighlight('NonText ctermbg=NONE guibg=NONE');
setHighlight('SpecialKey ctermbg=NONE guibg=NONE');
setHighlight('EndOfBuffer ctermbg=NONE guibg=NONE');
setHighlight('LineNr ctermbg=NONE guibg=NONE');
setHighlight('Folded ctermbg=NONE guibg=NONE');
setHighlight('SignColumn ctermbg=NONE guibg=NONE');
setHighlight('NormalFloat ctermbg=NONE guibg=NONE');
setHighlight('Pmenu ctermbg=NONE guibg=NONE');

setHighlight('TSKeyword gui=italic,bold guifg=#88C0D0');
