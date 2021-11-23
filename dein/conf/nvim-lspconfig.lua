-------------- Lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lspconfig = require'lspconfig'

lspconfig.sumneko_lua.setup {
        cmd = {
                'lua-language-server',
                '-E',
        },
        settings = {
                Lua = {
                        runtime = {
                                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT',
                                -- Setup your lua path
                                path = runtime_path,
                        },
                        diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = {'vim'},
                        },
                        workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                                enable = false,
                        },
                },
        },
}

---------


---------- C++
lspconfig.ccls.setup {
        single_file_support = true,
        root_dir = lspconfig.util.root_pattern("compile_commands.json", ".ccls", "compile_flags.txt", ".git","./") or lspconfig.util.dirname,
        init_options = {
                cache = {
                        directory = "/tmp/.ccls-cache";
                },
                compilationDatabaseDirectory = "build";
                index = {
                        threads = 0;
                },
                clang = {
                        excludeArgs = { "-frounding-math"} ;
                },
        },
}

---------

---- Vim script
lspconfig.vimls.setup{}


---- TypeScript
--lspconfig.tsserver.setup{}
--
---- Deno
lspconfig.denols.setup{}


----GLSL
local configs = require 'lspconfig/configs'
configs.glslls = {
        default_config = {
                cmd = {
                        'glslls',
                        '--stdin',
                },
                filetypes = {'glsl'},
                root_dir = lspconfig.util.root_pattern('./'),
                single_file_support = true,
        }
}

configs.glslls.setup{}

-----
