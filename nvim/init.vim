" カラースキーマ
"colorscheme NeoSolarized
"set background=dark

"フォント設定
set guifont=MyricaM\ M:h15

"バックアップファイル作成場所
set backup
set swapfile
set undofile
set backupdir=$HOME/vi
set directory=$HOME/vi
set undodir=$HOME/vi

"タブの画面上での幅
set tabstop=4
set shiftwidth=4

" 画面上のタブを常に表示
set showtabline=2  

"タブをスペースに展開しない
"set noexpandtab
set expandtab

"行数表示
set nu

"自動インデント
set autoindent
"バックスペースでインデント・改行削除
set backspace=2

"buftabsの設定
"ステータスラインを常に表示
set laststatus=2

"バッファを保存しなくても他のバッファを表示できるように
set hidden

" 検索のときに大文字、小文字を区別しない
set ic

"buftabsでファイル名のみを表示
let buftabs_only_basename=1
"bufftabsをステータスラインに表示
let buftabs_in_statusline=1
"現在のバッファをハイライト
let g:buftabs_active_highlight_group="Visual"

let bufWxploerDetailedHelp=1

"インデントハイライトを有効化
let g:indent_guides_enable_on_vim_startup = 1

"インデントハイライトの設定
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

"％コマンドのジャンプ機能拡張
source $VIMRUNTIME/macros/matchit.vim
let b:match_words = "<:>,(:),{:},[:],\</*\>:\<*/\>,\<#if\>:\<#endif\>"


"$TODAYと入力すると日付に変換される
let $TODAY = strftime('%Y%m%d')

"左右でバッファの移動
:nmap <Right> :bnext <CR>
:nmap <Left> :bprev <CR>
:nmap <S-Right> :blast <CR>
:nmap <S-Left> :bfirst <CR>

"ステータスバーの表示を変更
let &statusline='%F%m%r%h%w [FORMAT=%{&ff}] [ENC=%{&fileencoding}] [TYPE=%Y] [ASCII=\%03.3b] [HEX=\%02.2B] [POS=%04l,%04v][%p%%] [LEN=%L]'

" yank → clipbord
set clipboard+=unnamedplus

"quickfix を <ESC><ESC>で閉じる
au Filetype qf noremap <silent> <buffer> <ESC><ESC> :q<CR>
au Filetype qf inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

if &compatible
  set nocompatible
endif

"タグ複数あることを考慮してキーバンドを上書き
nnoremap <C-]> g<C-]> 

" python3 の有効
" 環境により変動　現状はpyenvを入れているので
" その中の一部のpythonのバージョンディレクトリを指定
let g:python2_host_prog=$HOME . '/.pyenv/shims/python2'
let g:python3_host_prog=$HOME . '/.pyenv/shims/python3'

" init.vimをロードする関数（nvimは$HOMEに設定がないのでリロードが面倒)
let $NVIM_SETTINGS=$XDG_CONFIG_HOME . '/nvim/init.vim'

""" Plugin """""""""""""""""""""""""""""""""""""""
" dein.vim
let s:plugins=$XDG_CONFIG_HOME . '/nvim/plugins'
let s:dein_path=s:plugins . '/dein.vim'
let $MY_DEIN_SETTINGS=$XDG_CONFIG_HOME . '/nvim/dein'
execute "set runtimepath+=" . s:dein_path


if dein#load_state(s:plugins)
    call dein#begin(s:plugins)

    call dein#add(s:dein_path)
"    call dein#load_toml($MY_DEIN_SETTINGS . '/test.toml', {'lazy' : 0})
    call dein#load_toml($MY_DEIN_SETTINGS . '/dein.toml', {'lazy' : 0})
    call dein#load_toml($MY_DEIN_SETTINGS . '/dein_lazy.toml', {'lazy' : 1})
    call dein#load_toml($MY_DEIN_SETTINGS . '/dein_lazy_cs.toml', {'lazy' : 2})
    call dein#load_toml($MY_DEIN_SETTINGS . '/dein_lazy_elixir.toml', {'lazy' : 3})
    call dein#load_toml($MY_DEIN_SETTINGS . '/dein_lazy_js.toml', {'lazy' : 4})
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

command! DeinInstall :call dein#install()
command! DeinUpdate :call dein#update()
command! DeinClean :call map(dein#check_clean(), "delete(v:val, 'rf')")
