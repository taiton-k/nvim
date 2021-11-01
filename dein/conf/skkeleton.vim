let skkeleton#config = {
        \ 'globalJisyo': '~/.config/skk/SKK-JISYO.L',
        \ 'userJisyo': '~/.config/skk/my_jisyo',
        \ 'immediatelyJisyoRW' : v:true,
        \ 'registerConvertResult': v:true,
        \ 'keepState' : v:true,
        \ 'setUndoPoint' :v:true,
        \ 'remoteJisyo': v:true,
        \ 'remoteJisyoHostname': 'localhost',
        \ 'remoteJisyoPort': '1178',
        \ 'skkServerResEnc' : 'utf-8',
        \ 'skkServerReqEnc' : 'utf-8',
        \ }

imap <silent><C-j> <Plug>(skkeleton-toggle)
cmap <silent><C-j> <Plug>(skkeleton-toggle)


