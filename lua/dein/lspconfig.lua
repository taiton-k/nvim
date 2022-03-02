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
                print('Diagnostic is disabled.');
        else
                for _,id in pairs(lsp_clients_id[fn.bufnr()]) do
                        diagnostic.enable(0,lsp.diagnostic.get_namespace(id));
                end

                diagnostic_is_enable[fn.bufnr()] = true;
                print('Diagnostic is enabled.');
        end
end

cmd('autocmd FileType cpp,lua,vim,glsl,typescript,nim nnoremap <buffer> <Leader>l <Cmd>call v:lua.lsp_toggle_diagnostics()<CR>');

local lsp_icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(lsp_icons) do
  local hl = "DiagnosticSign" .. type
  fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


diagnostic.config({
  virtual_text = {
    prefix = '● ', -- Could be '■', '▎', 'x'
  }
})

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
                        directory = fn.expand('~/.cache/ccls-cache');
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



lspconfig.denols.setup({
        single_file_support = true;
});




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

lspconfig.nimls.setup({
        cmd = { "nimlsp" },
        filetypes = { "nim" },
        root_dir = function(fname)
                return lspconfig.util.root_pattern '*.nimble'(fname) or lspconfig.util.find_git_ancestor(fname)
        end,
        single_file_support = true,
});
