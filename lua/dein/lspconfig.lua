local lspconfig = require('lspconfig');



lspconfig.sumneco_lua.setup({
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
                                '-Weverything',
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
