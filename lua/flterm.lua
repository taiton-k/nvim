local api = vim.api;
local o = vim.o;
local cmd = vim.cmd;
local flterm = {};

flterm.buf_handle = -1;
flterm.win_handle = -1;
local win_opts = {
        relative = 'editor';
        width = math.floor(o.columns*0.70710678);
        height = math.floor(o.lines*0.70710678);
        col = math.floor((o.columns-o.columns*0.70710678)/2);
        row = math.floor((o.lines-o.lines*0.70710678)/2);
        anchor = 'NW';
        style = 'minimal';
}

flterm.open_term = function ()
        if not api.nvim_buf_is_valid(flterm.buf_handle) then
                flterm.buf_handle = api.nvim_create_buf(true,true);
                if flterm.buf_handle == 0 then
                        api.nvim_err_writeln('[flTerm]Faild to create buffer.');
                end
        end

        flterm.win_handle = api.nvim_open_win(flterm.buf_handle,true,win_opts);
        if flterm.win_handle == 0 then
                api.nvim_err_writeln('[flTerm]Faild to create window.')
        end

        if o.buftype ~= 'terminal' then
                cmd('terminal');
        end
end

flterm.close_term = function ()
        api.nvim_win_close(flterm.win_handle,false);
end

flterm.toggle_term = function ()
        if flterm.win_handle and api.nvim_win_is_valid(flterm.win_handle) then
                flterm.close_term();
        else
                flterm.open_term();
        end
end

flterm.run_cmd = function (command)
        if not api.nvim_buf_is_valid(flterm.buf_handle) then
                flterm.buf_handle = api.nvim_create_buf(false,true);
                if flterm.buf_handle == 0 then
                        api.nvim_err_writeln('[flTerm]Faild to create buffer.');
                end
        end

        flterm.win_handle = api.nvim_open_win(flterm.buf_handle,true,win_opts);
        if flterm.win_handle == 0 then
                api.nvim_err_writeln('[flTerm]Faild to create window.')
        end

        cmd('edit term://' .. command);
end

flterm.reset = function ()
        if api.nvim_win_is_valid(flterm.win_handle) then
                flterm.close_term();
        end

        api.nvim_buf_delete(flterm.buf_handle);
end

flterm.setup = function (opts)
        if opts then
                for i,v in pairs(opts) do
                        win_opts[i] = v;
                end
        end

        api.nvim_add_user_command('FlTermOpen','call v:lua.require("flterm").open_term()',{});
        api.nvim_add_user_command('FlTermClose','call v:lua.require("flterm").close_term()',{});
        api.nvim_add_user_command('FlTermToggle','call v:lua.require("flterm").toggle_term()',{});
        api.nvim_add_user_command('FlTermRun','call v:lua.require("flterm").run_cmd("<args>")',{nargs = '*'});
        api.nvim_add_user_command('FlTermReset','call v:lua.require("flterm").reset()',{});

        api.nvim_set_keymap('','<Plug>(flTermOpen)','<Cmd>call v:lua.require("flterm").open_term()<CR>',{});
        api.nvim_set_keymap('','<Plug>(flTermClose)','<Cmd>call v:lua.require("flterm").close_term()<CR>',{});
        api.nvim_set_keymap('','<Plug>(flTermToggle)','<Cmd>call v:lua.require("flterm").toggle_term()<CR>',{});
end

return flterm;
