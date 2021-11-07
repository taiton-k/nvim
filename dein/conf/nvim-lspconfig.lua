-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lspconfig = require'lspconfig'

-------------- Lua
lspconfig.sumneko_lua.setup {
        cmd = {
                sumneko_binary,
                "-E",
                sumneko_root_path .. "/main.lua"
        };
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
        init_options = {
                cache = {
                        directory = ".ccls-cache";
                };
        }
}

---------

---- Vim script
lspconfig.vimls.setup{}


---- TypeScript
--lspconfig.tsserver.setup{}
--
---- Deno
lspconfig.denols.setup{}

