let skkeleton#config = {
        \ 'globalJisyo': expand('~/.skk/SKK-JISYO.L'),
        \ 'registerConvertResult': v:true,
        \ 'userJisyo': expand('~/.config/skk/my_jisyo'),
        \ 'remoteJisyo': v:true,
        \ 'remoteJisyoHostname': 'localhost',
        \ 'remoteJisyoPort': '1178'
        \ }

imap <C-j> <Plug>(skkeleton-enable)

