function! s:SkkeletonInitialize() abort
        call skkeleton#config({
                \ 'globalJisyo': '~/.config/skk/SKK-JISYO.L',
                \ 'userJisyo': '~/.config/skk/my_jisyo',
                \ 'immediatelyJisyoRW' : v:true,
                \ 'registerConvertResult': v:true,
                \ 'keepState' : v:true,
                \ 'setUndoPoint' :v:true,
                \ 'usePopup' : v:true,
                \ 'markerHenkan' : "▽ ",
                \ 'markerHenkanSelect' : "▼ ",
                \ 'useSkkServer': v:true,
                \ 'skkServerHost': '127.0.0.1',
                \ 'skkServerPort': '1178',
                \ 'skkServerResEnc' : 'utf-8',
                \ 'skkServerReqEnc' : 'utf-8',
                \ })
endfunction
autocmd conf User skkeleton-initialize-pre call s:SkkeletonInitialize()

imap <silent><C-j> <Plug>(skkeleton-toggle)
"cmap <silent><C-j> <Plug>(skkeleton-toggle)


