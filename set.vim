" Vimに元から入ってるプラグインを無効化"
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

" \ ←を押したときのインデント増加量を司る"
let g:vim_indent_cont = 1

set mouse+=a "マウスを有効化
set number "今何行かを表示"
set nowrap "いっちゃん端までいっても折り返さない

filetype plugin indent on "ファイルタイプ検出、プラグイン、インデントを有効にする
syntax enable "シンタックスハイライトを有効にする

"タブの設定
set tabstop=8 " <Tab>を押した時の幅をスペース8つ分にする"
set shiftwidth=8 " Vimが認識するタブの幅をスペース8つ分にする"
set expandtab " タブ文字を半角スペースにする"
set smarttab " 何か賢くインデントを調整してくれる奴"
set shiftround " インデントを shiftwidth の値の倍数にまとめる (<< や >> に適応される)"
set softtabstop=8 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する

set showmatch matchtime=1

set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=single " 曖昧幅の文字を半角にする


set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト


set termguicolors    " ターミナルでも True Color を使えるようにする。
set pumblend=25     " ポップアップメニューの透明度
set pumheight=15     " ポップアップメニューの高さ

set hidden " バッファを切り替えても「ファイルが保存されてないよ！」っていうエラーを出さないようにする"

set splitright         "画面を縦分割する際に右に開く

set clipboard+=unnamedplus "yank した文字列をクリップボードにコピー

set wrapscan " 一番下までいったら上まで戻る

set showtabline=2 " 常にタブページのラベルを表示
set noshowmode " モードの表記を消す

set list " 空白文字の可視化"
set listchars=eol:↴

"set cursorline " カーソルのある行を強調表示
"set cursorcolumn " カーソルのある列を強調表示

set whichwrap=b,s,h,l,[,],<,>,~ " カーソルの回り込みをできるようにする"

