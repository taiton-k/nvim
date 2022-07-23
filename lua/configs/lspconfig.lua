local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
local util = require("lspconfig.util")

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
        root_dir =  util.root_pattern("*"),
        init_options = {
                compilationDatabaseDirectory = "build",
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


configs.glslls = {
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



local diagnostic = vim.diagnostic;

diagnostic.config({
        virtual_text = {
                prefix = '● ',
        },
        update_in_insert = false,
})



local diagnostic_is_hidden = {}
local diagnostic_is_enable = true

local showDiagnostic = function ()
        if diagnostic_is_hidden[vim.fn.bufnr()] and diagnostic_is_enable then
                diagnostic_is_hidden[vim.fn.bufnr()] = false
                diagnostic.enable(0)
        end
end

local hideDiagnostic = function ()
        if (not diagnostic_is_hidden[vim.fn.bufnr()]) and diagnostic_is_enable then
                diagnostic_is_hidden[vim.fn.bufnr()] = true
                diagnostic.disable(0)
        end
end

local toggleDiagnostic = function ()
        if diagnostic_is_enable then
                hideDiagnostic()
                diagnostic_is_enable = false
                print("Diagnostic was disabled.")
        else
                showDiagnostic()
                diagnostic_is_enable = true
                print("Diagnostic was enabled.")
        end
end

local setAutocmd = function ()
        vim.api.nvim_create_autocmd("CursorMoved", {
                callback = hideDiagnostic,
                buffer = 0,
        })
        vim.api.nvim_create_autocmd("CursorHold", {
                callback = showDiagnostic,
                buffer = 0,
        })
end

setAutocmd()

vim.api.nvim_create_autocmd("FileType", {
        pattern = vim.fn["dein#get"]("nvim-lspconfig").on_ft,
        callback = setAutocmd
})

vim.keymap.set("n", "<Leader>l", toggleDiagnostic)
