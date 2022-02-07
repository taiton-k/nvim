local utils = {};

utils.make_highlight_group = function (opts)
        local args;

        --[[if opts.term then
                args = args .. 'term=';
                if type(opts.type.type) == 'string' then
                        args = args .. opts.type.type;
                else
                        for i in pairs(opts.term) do
                                args = args .. i .. ",";
                        end
                end
        end]]

        if opts.cterm then
                args = args .. 'ctermfg=' .. opts.cterm.fg .. ' ';

                args = args .. 'ctermbg=' .. opts.cterm.bg .. ' ';

                if type(opts.) then
                        for i in pairs(opts.cterm.sp) do
                                args = args .. 'ctermul=' .. 
                        end
                end
        end

        if opts.gui then
        end

        vim.cmd('highlight ' .. args);
end

utils.generate_line_string = function (components)
        
end

return utils;
