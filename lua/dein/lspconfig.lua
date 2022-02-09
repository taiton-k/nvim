--local api = vim.api;
local lsp = vim.lsp;
local fn = vim.fn;
local cmd = vim.cmd;

local clients_data = {};
local function detach_clients ()
        local clients = lsp.buf_get_clients(0);

        clients_data[fn.bufnr()] = {};

        for id,_ in pairs(clients) do
                table.insert(clients_data[fn.bufnr()],id);
                lsp.buf_detach_client(0,id);
        end
end

local function attach_clients ()
        for id in pairs(clients_data[fn.bufnr()]) do
                lsp.buf_attach_client(0,id);
        end
end

function _G.lsp_toggle_clients ()
        if #lsp.buf_get_clients(0) == 0 then
                attach_clients();
        else
                detach_clients();
        end
end

cmd('autocmd FileType cpp,lua,vim,glsl,typescript nnoremap <buffer> <Leader>l <Cmd>call v:lua.lsp_toggle_clients()<CR>');



local lspconfig = require('lspconfig');

lspconfig.sumneko_lua.setup({
        cmd = {
                'lua-language-server',
                '-E',
        };
        settings = {
                Lua = {
                        runtime = {
                                version = 'LuaJIT';
                        };
                        diagnostics = {
                                globals = {'vim'};
                        };
                        workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                        };
                        telemetry = {
                                enable = false,
                        };
                };
        };
});



lspconfig.ccls.setup({
        single_file_support = true;
        root_dir = lspconfig.util.root_pattern("compile_commands.json", ".ccls", "compile_flags.txt", ".git","./") or lspconfig.util.dirname,
        init_options = {
                cache = {
                        directory = '/tmp/ccls-cache';
                };
                index = {
                        threads = 1;
                };
                clang = {
                        excludeArgs = {
                                '-frounding-math',
                        };
                        extraArgs = {
                                '-std=c++17',
                                '-Wall',
                                '-Wextra',
                        };
                };
        };
});




lspconfig.vimls.setup({});



lspconfig.denols.setup({});




local configs = require('lspconfig.configs')
configs.glslls = {
        default_config = {
                cmd = {
                        'glslls',
                        '--stdin',
                        --'-p',
                        --'-v',
                        --'-l',
                        --'glslls.log',
                },
                filetypes = {'glsl'},
                root_dir = lspconfig.util.root_pattern('./'),
                --root_dir = function () return lspconfig.util.root_pattern('./') end,
                single_file_support = true,
        }
}

lspconfig.glslls.setup{}
