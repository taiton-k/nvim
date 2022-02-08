local fn = vim.fn;
local api = vim.api;
local cmd = vim.cmd;

function _G.skkeleton_initialize ()
        fn['skkeleton#config']({
                globalJisyo = '~/.config/skk/SKK-JISYO.Lemoji.utf8';
                globalJisyoEncoding = 'utf-8';
                userJisyo = '~/.config/skk/my_jisyo';
                immediatelyJisyoRW = true;
                registerConvertResult = true;
                keepState = true;
                setUndoPoint = true;
                usePopup = true;
                markerHenkan = '▽ ';
                markerHenkanSelect = '▼ ',
                useSkkServer = true;
                skkServerHost = '127.0.0.1';
                skkServerPort = 1178;
                skkServerResEnc = 'utf-8';
                skkServerReqEnc = 'utf-8';
        });
end
cmd('autocmd User skkeleton-initialize-pre call v:lua.skkeleton_initialize()');

api.nvim_set_keymap('!','<C-j>','<Plug>(skkeleton-toggle)',{});
