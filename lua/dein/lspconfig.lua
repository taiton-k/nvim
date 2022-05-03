--local api = vim.api;
local fn = vim.fn;
local cmd = vim.cmd;
local diagnostic = vim.diagnostic;

local is_diagnostic_enable = {};

local toggling_lsp = true;
function _G.toggle_toggling_lsp ()
        if toggling_lsp == true then
                disable_diagnostics();
                toggling_lsp = false;
                print('Diagnostic is disabled.');
        else
                toggling_lsp = true;
                print('Diagnostic is enabled.');
        end
end

function _G.enable_diagnostics ()
        if toggling_lsp == true then
                if is_diagnostic_enable[fn.bufnr()]==false then
                        is_diagnostic_enable[fn.bufnr()] = true;
                        diagnostic.enable(0);
                        --print('Diagnostic is enabled.');
                end
        end
end

function _G.disable_diagnostics ()
        if toggling_lsp == true then
                if is_diagnostic_enable[fn.bufnr()]==nil or is_diagnostic_enable[fn.bufnr()]==true then
                        is_diagnostic_enable[fn.bufnr()] = false;
                        diagnostic.disable(0);
                        --print('Diagnostic is disabled.');
                end
        end
end

function _G.toggle_diagnostics ()
        if toggling_lsp == true then
                if is_diagnostic_enable[fn.bufnr()]==nil or is_diagnostic_enable[fn.bufnr()]==true then
                        disable_diagnostics();
                else
                        enable_diagnostics();
                end
        end
end

cmd('autocmd FileType cpp,lua,vim,glsl,typescript,nim nnoremap <buffer> <Leader>l <Cmd>call v:lua.toggle_toggling_lsp()<CR>');
cmd('autocmd FileType cpp,lua,vim,glsl,typescript,nim autocmd CursorHold <buffer> call v:lua.enable_diagnostics()');
cmd('autocmd FileType cpp,lua,vim,glsl,typescript,nim autocmd CursorMoved <buffer> call v:lua.disable_diagnostics()');

local lsp_icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(lsp_icons) do
  local hl = "DiagnosticSign" .. type
  fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


diagnostic.config({
        virtual_text = {
                prefix = '● ', -- Could be '■', '▎', 'x'
        };
        update_in_insert = false;
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
                        rotainInMemory = 2;
                };
                diagnostics = {
                        onChange = 750;
                };
                index = {
                        threads = 4;
                        comments = 0;
                };
--               highlight = {
--                       lsRanges = true;
--               };
                clang = {
                        excludeArgs = {
                                '-frounding-math',
                        };
                        extraArgs = {
                                '-Wall',
                                '-Wextra',
                                '-std=c++20'
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
