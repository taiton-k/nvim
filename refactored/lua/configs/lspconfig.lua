local lspconfig = require('lspconfig');

lspconfig.sumneko_lua.setup({
        cmd = {
                'lua-language-server',
                '-E'
        },
        settings = {
                Lua = {
                        runtime = {
                                version = 'LuaJIT'
                        },
                        diagnostics = {
                                globals = {'vim'}
                        },
                        workspace = {
                                library = vim.api.nvim_get_runtime_file("", true)
                        },
                        telemetry = {
                                enable = false
                        }
                }
        }
})



lspconfig.ccls.setup({
        single_file_support = true,
        root_dir = function () return "./" end,
        init_options = {
                cache = {
                        directory = vim.fn.expand('~/.cache/ccls-cache'),
                        rotainInMemory = 2,
                },
                diagnostics = {
                        onChange = 750,
                },
                index = {
                        threads = 4,
                        comments = 0,
                },
--               highlight = { lsRanges = true; };
                clang = {
                        extraArgs = {
                                '-Wall',
                                '-Wextra',
                                '-std=c++20'
                        }
                }
        }
})




lspconfig.vimls.setup({})



lspconfig.denols.setup({
        single_file_support = true;
})


lspconfig.configs.glslls = {
        default_config = {
                cmd = {
                        'glslls',
                        '--stdin',
                },
                filetypes = {'glsl'},
                root_dir = function () return './' end,
                single_file_support = true,
        }
}


lspconfig.nimls.setup({
        cmd = { "nimlsp" },
        filetypes = { "nim" },
        root_dir = function(fname)
                return lspconfig.util.root_pattern '*.nimble'(fname) or lspconfig.util.find_git_ancestor(fname)
        end,
        single_file_support = true,
})


lspconfig.hls.setup({
        settings = {
                haskell = {
                        checkProject = false;
                        plugin = {
                        }
                }
        }
})

