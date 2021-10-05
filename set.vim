set mouse+=a "マウスを有効化
set number "今何行かを表示"
set nowrap "いっちゃん端までいっても折り返さない

filetype plugin indent on "ファイルタイプ検出、プラグイン、インデントを有効にする
syntax enable "シンタックスハイライトを有効にする

"タブの設定
set tabstop=8 
set shiftwidth=8
set expandtab
set smarttab
set shiftround
set softtabstop=8 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する

set showmatch matchtime=1

set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=single " □や○文字が崩れる問題を解決


set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>


set termguicolors    " ターミナルでも True Color を使えるようにする。
set pumblend=25     " 0 〜 100 が指定できます。ドキュメントによると 5 〜 30 くらいが適当だそうです。

set hidden

set splitright         "画面を縦分割する際に右に開く

set clipboard+=unnamedplus "yank した文字列をクリップボードにコピー

set wrapscan " 一番下までいったら上まで戻る

set showtabline=2 " 常にタブページのラベルを表示
set noshowmode " モードの表記を消す

set list
set listchars=eol:↴

colorscheme nvcode
