"windowsの環境をmacに合わせるため
set runtimepath+=$HOME/.vim

"syntaxのon
syntax on

" 挿入モードで日本語入力に変更されるのを無効
set iminsert=0
set imsearch=0

" これをしないと候補選択時に Scratch ウィンドウが開いてしまう 
set completeopt=menu

"バックアップファイル作成場所
set backup
set backupdir=$HOME/vi
set swapfile
set directory=$HOME/vi

set undodir=$HOME/vi
set undofile
"文字コードの指定
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp

set fileformats=unix,dos,mac

if has('win32') || has('win64')
	"英語メニューにする
	source $VIMRUNTIME/delmenu.vim 
	set langmenu=none 
	source $VIMRUNTIME/menu.vim

	"英語メッセージにする
	if has("multi_lang")
	language C
	endif
endif

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

"テンプレートの読み込み
augroup templateload
	autocmd!
	autocmd BufNewFile *.cpp  0r $HOME/.vim/template/cpp_template.cpp
	autocmd BufNewFile *.h    0r $HOME/.vim/template/cpp_template.h
	autocmd BufNewFile *.java 0r $HOME/.vim/template/java_template.java
	autocmd BufNewFile *.py   0r $HOME/.vim/template/python_template.py
	autocmd BufNewFile *.rb   0r $HOME/.vim/template/ruby_template.rb
augroup END

"カレントディレクトリを編集中ファイルの位置に
augroup grlcd
	autocmd!
	autocmd BufEnter * lcd %:p:h
augroup END

"$TODAYと入力すると日付に変換される
let $TODAY = strftime('%Y%m%d')

"ｘｍｌの閉じタグを自動挿入
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END


"デフォルトでは存在する上部のタブを非表示に
set guioptions-=T

"左右でバッファの移動
:nmap <Right> :bnext <CR>
:nmap <Left> :bprev <CR>
:nmap <S-Right> :blast <CR>
:nmap <S-Left> :bfirst <CR>

"自動改行の禁止
set formatoptions=q

" create directory automatically
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force ||
            \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END

"自動的にquick-fixを開く
autocmd QuickFixCmdPost *grep* cwindow


"go言語の設定
if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
endif

setlocal omnifunc=syntaxcomplete#Complete

"ステータスバーの表示を変更
let &statusline='%F%m%r%h%w [FORMAT=%{&ff}] [ENC=%{&fileencoding}] [TYPE=%Y] [ASCII=\%03.3b] [HEX=\%02.2B] [POS=%04l,%04v][%p%%] [LEN=%L]'

"タグ複数あることを考慮してキーバンドを上書き
nnoremap <C-]> g<C-]> 

"""""""" 以下プラグインの関連設定  """"""""""""""""

"""" プラグイン管理プラグイン設定 """""""""
"vimプラグインを.vim/bundleに
call pathogen#runtime_append_all_bundles()

set nocompatible
filetype off


" yank → clipbord
set clipboard=unnamed,autoselect

"quickfix を <ESC><ESC>で閉じる
au Filetype qf noremap <silent> <buffer> <ESC><ESC> :q<CR>
au Filetype qf inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	call neobundle#begin(expand('~/.vim/bundle/neobundle/plugins'))

	NeoBundleFetch 'Shougo/neobundle.vim'

	"""""""  プラグインのパスを管理
	NeoBundle 'Shougo/unite.vim.git'
	NeoBundle 'Shougo/vimfiler.git'
	NeoBundle 'Shougo/neomru.vim'

	NeoBundle 'Shougo/vimproc', {
	  \ 'build' : {
		\ 'windows' : 'make -f make_mingw32.mak',
		\ 'cygwin' : 'make -f make_cygwin.mak',
		\ 'mac' : 'make -f make_mac.mak',
		\ 'unix' : 'make -f make_unix.mak',
	  \ },
	\ }

	NeoBundle 'Shougo/vimshell.git'

	" 入力補助
	NeoBundle 'Shougo/neocomplete.vim'
	NeoBundle 'Shougo/neosnippet'
	NeoBundle "Shougo/neosnippet-snippets"
	NeoBundle 'AndrewRadev/switch.vim'

	NeoBundle 'nathanaelkane/vim-indent-guides'

	NeoBundle 'vim-scripts/YankRing.vim'

	NeoBundle 'kien/ctrlp.vim'

	NeoBundle 'thinca/vim-quickrun'

	NeoBundle 'sjl/gundo.vim'

	"cpp
"	NeoBundle "vim-scripts/taglist.vim"
"	NeoBundleLazy 'kana/vim-altr'

	" python
	NeoBundle 'kevinw/pyflakes-vim'
	NeoBundle 'jmcantrell/vim-virtualenv'

	NeoBundleLazy "davidhalter/jedi-vim", {
		  \ "autoload": {
		  \   "filetypes": ["python", "python3", "djangohtml"],
		  \ },
		  \ "build": {
		  \   "mac": "pip install jedi",
		  \   "unix": "pip install jedi",
		  \ }}

	" ctags
	NeoBundle 'szw/vim-tags'
"	NeoBundle 'soramugi/auto-ctags.vim'
	NeoBundleLazy 'alpaca-tc/alpaca_tags', {
      \ 'depends': 'Shougo/vimproc',
      \ 'autoload' : {
      \   'commands': ['TagsUpdate', 'TagsSet', 'TagsBundle']
      \ }}

	" cs
	NeoBundleLazy 'nosami/Omnisharp', {
	\   'autoload': {'filetypes': ['cs']},
	\   'build': {
	\     'mac': 'xbuild server/OmniSharp.sln /p:Platform="Any CPU"',
	\     'unix': 'xbuild server/OmniSharp.sln',
	\   }
	\ }
	
	" evernote連携
	NeoBundle 'kakkyz81/evervim'
	"NeoBundle 'tyru/restart.vim'
	
	"ソースのコメントインorアウト
	NeoBundle 'tyru/caw.vim'

	" markdown
	NeoBundle 'plasticboy/vim-markdown'
	NeoBundle 'kannokanno/previm'
	NeoBundle 'tyru/open-browser.vim'


	"textobj
	NeoBundle 'kana/vim-textobj-user'
	NeoBundle 'bps/vim-textobj-python'

	"cpp
	NeoBundle 'osyo-manga/vim-marching'
	NeoBundleLazy 'vim-jp/cpp-vim', {
				\ 'autoload' : {'filetypes' : 'cpp'}
				\ }

	NeoBundle 'Shougo/unite-outline'

	" clojure plugin
	NeoBundle 'guns/vim-clojure-static'
	NeoBundle 'kien/rainbow_parentheses.vim'
	NeoBundle 'tpope/vim-fireplace'
	NeoBundle 'tpope/vim-classpath'

	"ruby
	NeoBundle 'vim-ruby/vim-ruby'
" 	NeoBundle "osyo-manga/vim-monster"
	NeoBundle "Shougo/neocomplcache-rsense.vim"
	NeoBundle "vim-scripts/ruby-matchit"
	NeoBundle "basyura/unite-rails"

	

    "自作
    NeoBundle 'YuukiTsuchida/ctags-auto'
call neobundle#end()

endif

filetype plugin on
filetype indent on

""""""""""""""
" evervim
let g:evervim_devtoken = 'S=s277:U=2348cb2:E=14c4564bd42:C=144edb39146:P=1cd:A=en-devtoken:V=2:H=3deac3d34388e1fd503f94c5f67c4b3f'

" vimtags  homebrewでインストールしたタグを使用する
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags -R {OPTIONS} {DIRECTORY} 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R {OPTIONS} `bundle show --paths` 2>/dev/null"


" OmniSharp
let g:OmniSharp_host = "http://localhost:2000"
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Don't Use smartcase.
let g:neocomplete#enable_smart_case = 0
let g:neocomplete#enable_auto_close_preview = 0
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist'
        \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

let g:neocomplete#enable_auto_select = 0
let g:neocomplete#disable_auto_complete = 0

" Enable heavy omni completion.

call neocomplete#custom#source('_', 'sorters', [])

if !exists('g:neocomplete#sources')
        let g:neocomplete#sources = {}
endif

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
let g:neocomplete#sources.cs = ['neosnippet', 'omni', 'buffer']
let g:neocomplete#enable_refresh_always = 0
let g:echodoc_enable_at_startup = 1
let g:neocomplete#enable_insert_char_pre = 1


nnoremap [omnisharp]    <Nop>
nmap <Space>os	[omnisharp]
au Filetype cs noremap <silent>[omnisharp]gd		:OmniSharpGotoDefinition<CR>
au Filetype cs noremap <silent>[omnisharp]fu		:OmniSharpFindUsages<CR>
au Filetype cs noremap <silent>[omnisharp]ca		:OmniSharpGetCodeActions<CR>
au Filetype cs noremap <silent>[omnisharp]rename	:OmniSharpRename<CR>
au Filetype cs noremap <silent>[omnisharp]reload	:OmniSharpReloadSolution<CR>
au Filetype cs noremap <silent>[omnisharp]format	:OmniSharpCodeFormat<CR>

" vimshell  guiの時読み込む
if has('mac') && has('gui')
"	let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/vimproc_mac.so'
	let g:vimproc_dll_path = $HOME . '/.vim/bundle/neobundle/plugins/vimproc/autoload/vimproc_mac.so'
elseif('win64') && has('gui')
	let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/vimproc_win64.dll'
endif

" neocomplete 
if neobundle#is_installed('neocomplete.vim')
	 " neocomplete用設定
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

	let g:neocomplete#sources#syntax#min_keyword_length = 3	

	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
		\ 'default' : '',
		\ 'vimshell' : $HOME.'/.vimshell_hist',
		\ 'scheme' : $HOME.'/.gosh_completions'
	\ }

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"	let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
"	let g:neocomplete#sources.cs = ['omni']
endif

"Uniteの設定
nnoremap [unite]    <Nop>
nmap     <Space>u [unite]
"Buffer一覧の表示 ctrl-b
noremap <silent> [unite]bu :Unite buffer<CR>
"ファイラーの立ち上げ
noremap <silent> [unite]f :Unite file<CR>
" Unite file_mru
noremap <silent> [unite]ofm :Unite file_mru<CR>
"ブックマーク一覧を開く
noremap <silent> [unite]bm	:Unite bookmark<CR>
"ブックマークに追加
noremap <silent> [unite]ad :UniteBookmarkAdd<CR>
" Uniteを<ESC>二回で終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" unite-grepのバックエンドをagに切り替える
" http://qiita.com/items/c8962f9325a5433dc50d
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

"Gundo
noremap <Leader>g :GundoToggle<CR>

"jedi-vim
let s:hooks = neobundle#get_hooks("jedi-vim")
function! s:hooks.on_source(bundle)
  " jediにvimの設定を任せると'completeopt+=preview'するので
  " 自動設定機能をOFFにし手動で設定を行う
  let g:jedi#auto_vim_configuration = 0
  " 補完の最初の項目が選択された状態だと使いにくいためオフにする
  let g:jedi#popup_select_first = 0
  " quickrunと被るため大文字に変更
  let g:jedi#rename_command = '<Leader>R'
  " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
  let g:jedi#goto_command = '<Leader>G'
  let g:jedi#popup_on_dot = 0
endfunction

"jedi+neocomplete
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'


"vim-indent-guides設定
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_color_change_percent=30
let g:indent_guides_guide_size=1

"YankRing設定
"F7でヤンクの履歴取得
nnoremap <silent><F7> :YRShow<CR>
let g:yankring_max_history=10
let g:yankring_window_height=13

"VimFiler
:nmap <F9> :VimFilerExplorer -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<Cr>
autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! s:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
"  nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<Cr>
endfunction

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
  wincmd p
  exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', s:my_action)

let s:my_action = { 'is_selectable' : 1 }                     
function! s:my_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', s:my_action)

" vim-virtualenv
let g:virtualenv_directory = '~/.pythonbrew/venvs/Python-3.2.3'

" restart.vim
" 終了時に保存するセッションオプションを設定する
"let g:restart_sessionoptions
"    \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'


" NeoSnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
 
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
 
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:neosnippet#snippets_directory = '~/.vim/vim_mysnippet/'

let g:neosnippet#enable_preview = 1

" vim markdown
au BufRead,BufNewFile *.md set filetype=markdown


"NeoBundle "osyo-manga/vim-marching"
let g:marching_clang_command = "/usr/bin/clang++"
" 非同期ではなくて同期処理で補完する
let g:marching_backend = "sync_clang_command"

" オプションの設定
" これは clang のコマンドに渡される
let g:marching_clang_command_option="-std=c++1y"


" neocomplete.vim と併用して使用する場合
" neocomplete.vim を使用すれば自動補完になる
let g:marching_enable_neocomplete = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'


"rainbow_parentheses
" rainbow_parentheses.vimの括弧の色付けを有効化
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare

" C++ の場合は、<> もハイライト
autocmd FileType cpp :RainbowParenthesesLoadChevrons

"osyo-manga/vim-monster
"let g:neocomplete#sources#omni#input_patterns = {
"\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
"\}

" tyru/caw.vim
" \sc でカーソル行をコメントアウトor解除
nmap \sc <Plug>(caw:I:toggle)
vmap \sc <Plug>(caw:I:toggle)


" AndrewRadev/switch.vim
nnoremap - :Switch<cr>

"NeoBundleLazy 'kana/vim-altr'
"nnoremap <Space>a <Plug>(altr-forward)

"NeoBundle "vim-scripts/taglist.vim"
"nnoremap <Space>tlist :Tlist<CR>



"""""""""" cpp setting """"""""""""""""""""""""""""""
" インクルードディレクトリのパスを設定
let g:marching_include_paths = [
\   "/Applications/Android/boost_1_55_0",
\	"/Users/tsuchidayuuki/Library/Developer/android/android-ndk-r9d/sources/cxx-stl/llvm-libc++/libcxx/include",
\	"/Users/tsuchidayuuki/Library/Developer/android/android-ndk-r9d/platforms/android-14/arch-arm/usr/include",
\	"/Users/tsuchidayuuki/Documents/bx56amazon/gitsvn/maav/jni",
\	"/Users/tsuchidayuuki/Documents/bx56amazon/gitsvn/maav/jni/mautils",
\  "/Users/tsuchidayuuki/Documents/bx56amazon/gitsvn/maav/jni/tinyxml",
\  "/Users/tsuchidayuuki/Documents/bx56amazon/gitsvn/maav/jni/curl/include/curl",
\  "/Users/tsuchidayuuki/Documents/bx56amazon/gitsvn/maav/jni/openssl/include/openssl",
\]

"set tags=$HOME/Documents/bx56amazon/gitsvn/maav/tags

" tagsの設定
" gitのルートに存在するtagsを取得する
"let top = system("git rev-parse --show-toplevel")
"echo top
"if v:shell_error == 0
"    echo ( top . "/tags" )
"    echo join([top, '/tags'], '' )
"    set tags=top
"endif

