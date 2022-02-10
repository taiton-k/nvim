--local api = vim.api;
local fn = vim.fn;
local cmd = vim.cmd;
local lsp = vim.lsp;
local diagnostic = vim.diagnostic;

local diagnostic_is_enable = {};

local lsp_clients_id = {};

function _G.lsp_toggle_diagnostics ()
        if not lsp_clients_id[fn.bufnr()] then
                lsp_clients_id[fn.bufnr()] = {};
                for id,_ in pairs(lsp.buf_get_clients(0)) do
                        table.insert(lsp_clients_id[fn.bufnr()],id);
                end
        end

        if diagnostic_is_enable[fn.bufnr()]==nil or diagnostic_is_enable[fn.bufnr()]==true then
                for _,id in pairs(lsp_clients_id[fn.bufnr()]) do
                        diagnostic.disable(0,lsp.diagnostic.get_namespace(id));
                end

                diagnostic_is_enable[fn.bufnr()] = false;
        else
                for _,id in pairs(lsp_clients_id[fn.bufnr()]) do
                        diagnostic.enable(0,lsp.diagnostic.get_namespace(id));
                end

                diagnostic_is_enable[fn.bufnr()] = true;
        end
end



cmd('autocmd FileType cpp,lua,vim,glsl,typescript nnoremap <buffer> <Leader>l <Cmd>call v:lua.lsp_toggle_diagnostics()<CR>');



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
