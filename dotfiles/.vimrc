""" General Settings """
" Enable 24-bit true colors if your terminal supports it.
if (has("termguicolors"))
	" https://github.com/vim/vim/issues/993#issuecomment-255651605
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Word dictionary
" set dictionary=/usr/share/dict/words

" Set path recursively to all sub-directory
set path+=**

"  Sets how many line of history VIM remembers
set history=500

" Undo history
set undolevels=500

" Auto read file when changed from outside
set autoread
au FocusGained,BufEnter * checktime

" Always show current position
set ruler

" Enable Wild menu
set wildmenu

" Max number of tab pages
set tabpagemax=50

" Show line number
set number
set relativenumber

" Highlight current line
set nocursorline

" No error bells
set noerrorbells

" No visual bell
set novisualbell

" No show outputs
set showmode

" Tabs width
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

" Use empty spaces instead tabspace
set noexpandtab

" Enable indention
set autoindent
set smartindent
set wrap

" Enable filetype plugins
filetype plugin indent on

" 5 lines to cursor when moving vertically
set scrolloff=5

" 5 columns to cursor when moving horizontally
set sidescrolloff=5

" Linebreak on 500 characters
set linebreak
set tw=500

" Enable file syntax
syntax on

" File encoding
set encoding=utf-8 nobomb

" Height of commandbar
set cmdheight=2

" Searching
set hlsearch
set incsearch
set smartcase
set showmatch

" Buffer becomes hidden when abandoned
set hidden

" Performance
set lazyredraw
set ttyfast

" Enable magic for regular expression
set magic

" Show title as file name
set title

" Code Folds
set foldenable
set foldmethod=syntax
set foldminlines=20
set foldnestmax=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" How many tenths of a second to blink when matching brackets
set mat=2

" Ask for confirmation when before quitting an edited file
set confirm

" Don't show modeline
set nomodeline

" Set default shell
set shell=/bin/bash

" Enable spelling spell check
set spell

" Spell language
set spelllang=en_us

" Disable compatibiity of old vi command
set nocompatible

" Clipboard uses system clipboard
set clipboard+=unnamed,unnamedplus

" No Backup
set nobackup
set noswapfile

" Show tabs/spaces as special chars
set list
set showbreak=↪\
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" Automatically change directory according to active buffer
set noautochdir

" Split window
set splitbelow
set splitright

" mouse
set ttymouse=sgr
set mouse=a

" Terminal window size
set termwinsize=10x0

" completion with popup window
set complete+=t
set completeopt+=menu,noselect,noinsert,preview
set shortmess+=c
set belloff+=ctrlg
set omnifunc=syntaxcomplete#Complete

" Show count of matches
set shortmess-=S

" Vim file browser Net RW
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_silent= 1

" Ignore filetypes
set wildignore+=.pyc,.swp
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*
set wildignore+=*.DS_STORE,*.db,node_modules/**,*.jpg,*.png,*.gif
set wildignore+=*/coverage

""" Auto command Settings """
" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Commenting blocks of code
autocmd FileType c,cpp,java,scala	let b:comment_leader = '// '
autocmd FileType sh,zsh,ruby,python	let b:comment_leader = '# '
autocmd FileType conf,fstab			let b:comment_leader = '# '
autocmd FileType tex				let b:comment_leader = '% '
autocmd FileType mail				let b:comment_leader = '> '
autocmd FileType vim				let b:comment_leader = '" '

" Different settings for c/c++
autocmd FileType c,cpp
			\ set tabstop=8 |
			\ set softtabstop=8 |
			\ set shiftwidth=8

" Change fold method for vimscripts
autocmd FileType vim
			\ set foldmethod=manual |
			\ set foldminlines=2 |
			\ set foldnestmax=20
autocmd BufWinLeave .vimrc,*.vim mkview
autocmd BufWinEnter .vimrc,*.vim silent loadview

" Make sure all types of requirements.txt files get syntax highlighting.
autocmd BufNewFile,BufRead requirements*.txt set ft=python

" Make sure .aliases, .bash_aliases and similar files get syntax highlighting.
autocmd BufNewFile,BufRead .*aliases set ft=sh

" Ensure tabs don't get converted to spaces in Make files.
autocmd FileType make setlocal noexpandtab

""" Keybinding Settings """
" Edit/Reload vim config
exec "set <M-E>=\eE"
nnoremap <silent> <M-E>v :e $MYVIMRC<CR>
nnoremap <silent> <M-E>r :so $MYVIMRC<CR>

" Open vim terminal
exec "set <M-T>=\eT"
nnoremap <silent> <M-T> :terminal<CR>

" Quick save discarding changes
exec "set <M-w>=\ew"
nnoremap <silent> <M-w> :w!<CR>

" Close buffer
exec "set <M-q>=\eq"
nnoremap <silent> <M-q> :bd!<CR>

" Quit vim discarding changes
exec "set <M-Q>=\eQ"
nnoremap <silent> <M-Q> :q!<CR>

" Switch buffers
exec "set <M-`>=\e`"
exec "set <M-a>=\ea"
nnoremap <silent> <M-`> :bnext<CR>
nnoremap <silent> <M-a> :bprev<CR>

" Split navigation
exec "set <M-j>=\ej"
exec "set <M-k>=\ek"
exec "set <M-l>=\el"
exec "set <M-h>=\eh"
nnoremap <M-j> <C-W><C-J>
nnoremap <M-k> <C-W><C-K>
nnoremap <M-l> <C-W><C-L>
nnoremap <M-h> <C-W><C-H>

" Clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>Y "*y
noremap <Leader>P "*p

" File explorer
exec "set <M-f>=\ef"
nnoremap <silent> <M-f> :Explore<CR>

" Navigate the complete menu items like CTRL+n / CTRL+p would.
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" Select the complete menu item like CTRL+y would.
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" :"<CR>"

" Cancel the complete menu item like CTRL+e would.
inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"

" File finder
nnoremap <leader>ff :find

" Comment/Uncomment block of code
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

"""""""""""""""""""""""""""
""" Special Keybindings """
"""""""""""""""""""""""""""
" Remove unused whitespace from entire file
nnoremap <silent> <leader>sw :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Auto indent entire file
nnoremap <silent> <leader>si gg=G

" Retab entire file
nnoremap <silent> <leader>st :retab<CR>

" Tags creation
nnoremap <silent>st :!ctags -R .<CR>

" Toggle quickfix window.
function! QuickFix_toggle()
	for i in range(1, winnr('$'))
		let bnum = winbufnr(i)
		if getbufvar(bnum, '&buftype') == 'quickfix'
			cclose
			return
		endif
	endfor

	copen
endfunction
nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>

""" Plugins """
call plug#begin("$HOME/.vim/plugged")
Plug 'mhinz/vim-signify'            " Show git file changes
Plug 'lilydjwg/colorizer'           " colorize text in the form #rgb, #rgba, #rrggbb
Plug 'szw/vim-maximizer'            " maximize/minimize split windows
Plug 'tpope/vim-fugitive'           " Git wrapper for vim
Plug 'vim-scripts/AutoComplPop'     " Automatic completion menu popup in insert mode
call plug#end()

""" Plugin Settings """
" Signify
set updatetime=100

" Vim Maximizer
exec "set <M-F>=\eF"
nnoremap <silent> <M-F> :MaximizerToggle<CR>

""" VIM Colors """
set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

hi SpecialKey     term=bold ctermfg=58
hi NonText        term=bold ctermfg=240
hi Directory      term=bold ctermfg=120
hi ErrorMsg       term=standout ctermfg=252 ctermbg=95
hi IncSearch      term=reverse ctermfg=16 ctermbg=120
hi Search         term=reverse ctermfg=252 ctermbg=95
hi MoreMsg        term=bold ctermfg=252
hi ModeMsg        term=bold ctermfg=252
hi LineNr         term=underline ctermfg=250 ctermbg=235
hi Question       term=standout ctermfg=252
hi StatusLine     term=bold,reverse cterm=bold ctermfg=252 ctermbg=236
hi StatusLineNC   term=reverse cterm=bold ctermfg=240 ctermbg=236
hi VertSplit      term=reverse ctermfg=252 ctermbg=236
hi Title          term=bold ctermfg=95
hi Visual         term=reverse ctermfg=231 ctermbg=60
hi VisualNOS      term=bold,underline ctermfg=252 ctermbg=16
hi WarningMsg     term=standout ctermfg=252 ctermbg=95
hi WildMenu       term=standout cterm=bold ctermfg=177 ctermbg=16
hi Folded         term=standout ctermfg=142 ctermbg=16
hi FoldColumn     term=standout ctermfg=252 ctermbg=16
hi DiffAdd        term=bold ctermfg=252 ctermbg=59
hi DiffChange     term=bold ctermbg=54
hi DiffDelete     term=bold ctermfg=252 ctermbg=95
hi DiffText       term=reverse ctermfg=16 ctermbg=77
hi SignColumn     term=standout ctermfg=51 ctermbg=250
hi TabLine        term=underline cterm=underline ctermbg=248
hi TabLineSel     term=bold cterm=bold
hi TabLineFill    term=reverse ctermfg=234 ctermbg=252
hi CursorColumn   term=reverse ctermbg=235
hi CursorLine     term=underline ctermbg=235
hi Cursor         ctermfg=16 ctermbg=120
hi lCursor        ctermfg=234 ctermbg=252
hi Normal         ctermfg=252 ctermbg=234
hi Comment        term=bold ctermfg=241
hi Constant       term=underline ctermfg=142
hi Special        term=bold ctermfg=222
hi Identifier     term=underline ctermfg=74
hi Statement      term=bold ctermfg=77
hi PreProc        term=underline ctermfg=95
hi Type           term=underline ctermfg=177
hi Underlined     term=underline cterm=underline ctermfg=252
hi Ignore         ctermfg=240
hi Error          term=reverse ctermfg=88 ctermbg=16
hi Todo           term=standout ctermfg=252 ctermbg=95
hi String         ctermfg=85 ctermbg=16
hi Number         ctermfg=179
hi Boolean        ctermfg=46
hi Special        term=bold ctermfg=222
hi Identifier     term=underline ctermfg=74
hi Statement      term=bold ctermfg=77
hi PreProc        term=underline ctermfg=95
hi Type           term=underline ctermfg=177
hi Underlined     term=underline cterm=underline ctermfg=252
hi Ignore         ctermfg=240
hi Error          term=reverse ctermfg=88 ctermbg=16
hi Todo           term=standout ctermfg=252 ctermbg=95
hi String         ctermfg=85 ctermbg=16
hi Number         ctermfg=179
hi Boolean        ctermfg=46
hi User1          cterm=bold ctermfg=246 ctermbg=236
hi User2          cterm=bold ctermfg=120 ctermbg=236

hi Pmenu          gui=NONE   guifg=#cccccc   guibg=#222222
hi PMenuSel       gui=BOLD   guifg=#cccc66   guibg=#000000
hi PmenuSbar      gui=NONE   guifg=#cccccc   guibg=#000000
hi PmenuThumb     gui=NONE   guifg=#cccccc   guibg=#333333

hi SpellRare      gui=undercurl guifg=#000000 guibg=#cc66cc
hi SpellLocal     gui=undercurl guifg=#000000 guibg=#cccc66
hi SpellCap       gui=undercurl guifg=#000000 guibg=#66cccc
hi SpellBad       gui=undercurl guifg=#000000 guibg=#cc6c6c

hi MatchParen     gui=NONE      guifg=#ffffff   guibg=#005500

""" Statusline Configuration """
" Statusline Elements
set laststatus=2
set statusline=
set statusline+=%#CurrentMode#
set statusline+=%1*
set statusline+=\ %{g:currentmode[mode()]}
set statusline+=%*
set statusline+=%#FileStatus#
set statusline+=%3*
set statusline+=\ %.30f "filename with full path
set statusline+=%m      "modified flag
set statusline+=\ %*
set statusline+=%2*
set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%{&ff!='unix'?'['.&ff.']':''}                     "display a warning if fileformat isnt unix
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}   "display a warning if file encoding isnt utf-8
set statusline+=%*
set statusline+=%#GitStatus#
set statusline+=%5*
set statusline+=%{(exists('g:loaded_fugitive')?fugitive#statusline():'')}
set statusline+=%{GitStatus()}
set statusline+=%*
set statusline+=%7*%=%<%*      "left/right separator
set statusline+=%#Warning#
set statusline+=%6*
set statusline+=%{StatuslineTabWarning()}
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*
set statusline+=%#CursorLineColumn#
set statusline+=%1*
set statusline+=[%c\    "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P]   "percent through file
set statusline+=%*

" Additional Settings
hi User1 ctermfg=232 ctermbg=226
hi User2 ctermfg=232 ctermbg=195
hi User3 ctermfg=232 ctermbg=51
hi User4 ctermfg=black ctermbg=red
hi User5 ctermfg=black ctermbg=cyan
hi User6 ctermfg=black ctermbg=yellow
hi User7 ctermfg=black ctermbg=darkgray

let g:currentmode={
			\ 'n'  : 'NORMAL ',
			\ 'no' : 'N·Operator ',
			\ 'v'  : 'VISUAL ',
			\ 'V'  : 'V·Line ',
			\ 'x22' : 'V·Block ',
			\ 's'  : 'SELECT ',
			\ 'S'  : 'S·Line ',
			\ 'x19' : 'S·Block ',
			\ 'i'  : 'INSERT ',
			\ 'R'  : 'REPLACE ',
			\ 'Rv' : 'V·Replace ',
			\ 'c'  : 'COMMAND ',
			\ 'cv' : 'Vim Ex ',
			\ 'ce' : 'Ex ',
			\ 'r'  : 'PROMPT ',
			\ 'rm' : 'MORE ',
			\ 'r?' : 'CONFIRM ',
			\ '!'  : 'SHELL ',
			\ 't'  : 'TERMINAL '
			\}

" GitStatus
function! GitStatus()
	return sy#repo#get_stats_decorated()
endfunction

"recalculate the trailing whitespace warning when idle, and after saving
" autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
autocmd BufEnter,BufWrite * unlet! b:statusline_trailing_space_warning

"return warning message if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
	if !exists("b:statusline_trailing_space_warning")
		if !&modifiable
			let b:statusline_trailing_space_warning = ''
			return b:statusline_trailing_space_warning
		endif
		let trailing=search('\s\+$', 'nw')
		if trailing != 0
			let b:statusline_trailing_space_warning = '[Warning: Trailing Whitespaces(' . trailing . ')]'
		else
			let b:statusline_trailing_space_warning = ''
		endif
	endif
	return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
	let name = synIDattr(synID(line('.'),col('.'),1),'name')
	if name == ''
		return ''
	else
		return '[' . name . ']'
	endif
endfunction

"recalculate the tab warning flag when idle and after writing
" autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
autocmd BufEnter,BufWrite * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
	if !exists("b:statusline_tab_warning")
		let b:statusline_tab_warning = ''
		if !&modifiable
			return b:statusline_tab_warning
		endif
		let tabs = search('^\t', 'nw') != 0
		"find spaces that arent used as alignment in the first indent column
		let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0
		if tabs && spaces
			let b:statusline_tab_warning =  '[Warning: mixed-indenting]'
		elseif (spaces && !&et) || (tabs && &et)
			let b:statusline_tab_warning = '[Warning: &et]'
		endif
	endif
	return b:statusline_tab_warning
endfunction

" "recalculate the long line warning when idle and after saving
" autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
	if !exists("b:statusline_long_line_warning")
		if !&modifiable
			let b:statusline_long_line_warning = ''
			return b:statusline_long_line_warning
		endif
		let long_line_lens = s:LongLines()
		if len(long_line_lens) > 0
			let b:statusline_long_line_warning = "[" .
						\ '#' . len(long_line_lens) . "," .
						\ 'm' . s:Median(long_line_lens) . "," .
						\ '$' . max(long_line_lens) . "]"
		else
			let b:statusline_long_line_warning = ""
		endif
	endif
	return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
	let threshold = (&tw ? &tw : 80)
	let spaces = repeat(" ", &ts)
	let long_line_lens = []
	let i = 1
	while i <= line("$")
		let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
		if len > threshold
			call add(long_line_lens, len)
		endif
		let i += 1
	endwhile
	return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
	let nums = sort(a:nums)
	let l = len(nums)
	if l % 2 == 1
		let i = (l-1) / 2
		return nums[i]
	else
		return (nums[l/2] + nums[(l/2)-1]) / 2
	endif
endfunction

""" Tabline Configuration """

" Configuration
let g:buftabline_numbers    = 0
let g:buftabline_indicators = 1
let g:buftabline_separators = 1
let g:buftabline_separator  = '▎'
let g:buftabline_show       = 1
let g:buftabline_plug_max   = 50

hi BufTabLineCurrent    ctermfg=black ctermbg=green
hi BufTabLineActive     ctermfg=black ctermbg=green
hi BufTabLineHidden     ctermfg=black ctermbg=darkblue
hi BufTabLineFill       ctermfg=black ctermbg=darkgray
hi default link BufTabLineModifiedCurrent BufTabLineCurrent
hi default link BufTabLineModifiedActive  BufTabLineActive
hi default link BufTabLineModifiedHidden  BufTabLineHidden

let g:buftabline_numbers    = get(g:, 'buftabline_numbers',     0)
let g:buftabline_indicators = get(g:, 'buftabline_indicators',  1)
let g:buftabline_separators = get(g:, 'buftabline_separators',  1)
let g:buftabline_separator  = get(g:, 'buftabline_separator', ' ')
let g:buftabline_show       = get(g:, 'buftabline_show',        1)
let g:buftabline_plug_max   = get(g:, 'buftabline_plug_max',   50)

function! Buftabline_user_buffers() " help buffers are always unlisted, but quickfix buffers are not
	return filter(range(1,bufnr('$')),'buflisted(v:val) && "quickfix" !=? getbufvar(v:val, "&buftype")')
endfunction

function! s:switch_buffer(bufnum, clicks, button, mod)
	execute 'buffer' a:bufnum
endfunction

function s:SID()
	return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

let s:dirsep = fnamemodify(getcwd(),':p')[-1:]
let s:centerbuf = winbufnr(0)
let s:tablineat = has('tablineat')
let s:sid = s:SID() | delfunction s:SID

function! Buftabline_render()
	let show_num = g:buftabline_numbers == 1
	let show_ord = g:buftabline_numbers == 2
	let show_mod = g:buftabline_indicators
	let lpad     = g:buftabline_separators ? g:buftabline_separator : ' '

	let bufnums = Buftabline_user_buffers()
	let centerbuf = s:centerbuf " prevent tabline jumping around when non-user buffer current (e.g. help)

	" pick up data on all the buffers
	let tabs = []
	let path_tabs = []
	let tabs_per_tail = {}
	let currentbuf = winbufnr(0)
	let screen_num = 0
	for bufnum in bufnums
		let screen_num = show_num ? bufnum : show_ord ? screen_num + 1 : ''
		let tab = { 'num': bufnum, 'pre': '' }
		let tab.hilite = currentbuf == bufnum ? 'Current' : bufwinnr(bufnum) > 0 ? 'Active' : 'Hidden'
		if currentbuf == bufnum | let [centerbuf, s:centerbuf] = [bufnum, bufnum] | endif
		let bufpath = bufname(bufnum)
		if strlen(bufpath)
			let tab.path = fnamemodify(bufpath, ':p:~:.')
			let tab.sep = strridx(tab.path, s:dirsep, strlen(tab.path) - 2) " keep trailing dirsep
			let tab.label = tab.path[tab.sep + 1:]
			let pre = screen_num
			if getbufvar(bufnum, '&mod')
				let tab.hilite = 'Modified' . tab.hilite
				if show_mod | let pre = '+' . pre | endif
			endif
			if strlen(pre) | let tab.pre = pre . ' ' | endif
			let tabs_per_tail[tab.label] = get(tabs_per_tail, tab.label, 0) + 1
			let path_tabs += [tab]
		elseif -1 < index(['nofile','acwrite'], getbufvar(bufnum, '&buftype')) " scratch buffer
			let tab.label = ( show_mod ? '!' . screen_num : screen_num ? screen_num . ' !' : '!' )
		else " unnamed file
			let tab.label = ( show_mod && getbufvar(bufnum, '&mod') ? '+' : '' )
						\             . ( screen_num ? screen_num : '*' )
		endif
		let tabs += [tab]
	endfor

	" disambiguate same-basename files by adding trailing path segments
	while len(filter(tabs_per_tail, 'v:val > 1'))
		let [ambiguous, tabs_per_tail] = [tabs_per_tail, {}]
		for tab in path_tabs
			if -1 < tab.sep && has_key(ambiguous, tab.label)
				let tab.sep = strridx(tab.path, s:dirsep, tab.sep - 1)
				let tab.label = tab.path[tab.sep + 1:]
			endif
			let tabs_per_tail[tab.label] = get(tabs_per_tail, tab.label, 0) + 1
		endfor
	endwhile

	" now keep the current buffer center-screen as much as possible:

	" 1. setup
	let lft = { 'lasttab':  0, 'cut':  '.', 'indicator': '<', 'width': 0, 'half': &columns / 2 }
	let rgt = { 'lasttab': -1, 'cut': '.$', 'indicator': '>', 'width': 0, 'half': &columns - lft.half }

	" 2. sum the string lengths for the left and right halves
	let currentside = lft
	let lpad_width = strwidth(lpad)
	for tab in tabs
		let tab.width = lpad_width + strwidth(tab.pre) + strwidth(tab.label) + 1
		let tab.label = lpad . tab.pre . substitute(strtrans(tab.label), '%', '%%', 'g') . ' '
		if centerbuf == tab.num
			let halfwidth = tab.width / 2
			let lft.width += halfwidth
			let rgt.width += tab.width - halfwidth
			let currentside = rgt
			continue
		endif
		let currentside.width += tab.width
	endfor
	if currentside is lft " centered buffer not seen?
		" then blame any overflow on the right side, to protect the left
		let [lft.width, rgt.width] = [0, lft.width]
	endif

	" 3. toss away tabs and pieces until all fits:
	if ( lft.width + rgt.width ) > &columns
		let oversized
					\ = lft.width < lft.half ? [ [ rgt, &columns - lft.width ] ]
					\ : rgt.width < rgt.half ? [ [ lft, &columns - rgt.width ] ]
					\ :                        [ [ lft, lft.half ], [ rgt, rgt.half ] ]
		for [side, budget] in oversized
			let delta = side.width - budget
			" toss entire tabs to close the distance
			while delta >= tabs[side.lasttab].width
				let delta -= remove(tabs, side.lasttab).width
			endwhile
			" then snip at the last one to make it fit
			let endtab = tabs[side.lasttab]
			while delta > ( endtab.width - strwidth(strtrans(endtab.label)) )
				let endtab.label = substitute(endtab.label, side.cut, '', '')
			endwhile
			let endtab.label = substitute(endtab.label, side.cut, side.indicator, '')
		endfor
	endif

	if len(tabs) | let tabs[0].label = substitute(tabs[0].label, lpad, ' ', '') | endif

	let swallowclicks = '%'.(1 + tabpagenr('$')).'X'
	return s:tablineat
				\ ? join(map(tabs,'"%#BufTabLine".v:val.hilite."#" . "%".v:val.num."@'.s:sid.'switch_buffer@" . strtrans(v:val.label)'),'') . '%#BufTabLineFill#' . swallowclicks
				\ : swallowclicks . join(map(tabs,'"%#BufTabLine".v:val.hilite."#" . strtrans(v:val.label)'),'') . '%#BufTabLineFill#'
endfunction

function! Buftabline_update(zombie)
	set tabline=
	if tabpagenr('$') > 1 | set guioptions+=e showtabline=2 | return | endif
	set guioptions-=e
	if 0 == g:buftabline_show
		set showtabline=1
		return
	elseif 1 == g:buftabline_show
		" account for BufDelete triggering before buffer is actually deleted
		let bufnums = filter(Buftabline_user_buffers(), 'v:val != a:zombie')
		let &g:showtabline = 1 + ( len(bufnums) > 1 )
	elseif 2 == g:buftabline_show
		set showtabline=2
	endif
	set tabline=%!Buftabline_render()
endfunction

augroup BufTabLine
	autocmd!
	autocmd VimEnter  * call Buftabline_update(0)
	autocmd TabEnter  * call Buftabline_update(0)
	autocmd BufAdd    * call Buftabline_update(0)
	autocmd FileType qf call Buftabline_update(0)
	autocmd BufDelete * call Buftabline_update(str2nr(expand('<abuf>')))
augroup END

for s:n in range(1, g:buftabline_plug_max) + ( g:buftabline_plug_max > 0 ? [-1] : [] )
	let s:b = s:n == -1 ? -1 : s:n - 1
	execute printf("noremap <silent> <Plug>BufTabLine.Go(%d) :<C-U>exe 'b'.get(Buftabline_user_buffers(),%d,'')<cr>", s:n, s:b)
endfor
unlet! s:n s:b

if v:version < 703
	function s:transpile()
		let [ savelist, &list ] = [ &list, 0 ]
		redir => src
		silent function Buftabline_render
		redir END
		let &list = savelist
		let src = substitute(src, '\n\zs[0-9 ]*', '', 'g')
		let src = substitute(src, 'strwidth(strtrans(\([^)]\+\)))', 'strlen(substitute(\1, ''\p\|\(.\)'', ''x\1'', ''g''))', 'g')
		return src
	endfunction
	exe "delfunction Buftabline_render\n" . s:transpile()
	delfunction s:transpile
endif
