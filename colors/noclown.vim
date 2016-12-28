" noclown
"
" A mostly color free theme with a goal of not making your code look like a
" clown threw up.
"
" Propaganda:
" * http://www.linusakesson.net/programming/syntaxhighlighting/
" * http://kyleisom.net/blog/2012/10/17/syntax-off/
" * https://www.robertmelton.com/2016/04/10/syntax-highlighting-off/
"
" PUBLIC DOMAIN
" To the extent possible under law, Berk D. Demir has waived all copyright and
" related or neighboring rights to noclown color scheme for Vim.
" This work is published from: United States.


highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = "noclown"

" Terminals that don't support italics, resort to rendering them as standout.
" For comments and other things we italicize, this can become annoying very
" quickly.  We are going to ignore 'italic' attribute if the terminal doesn't
" know about it.
if (has('gui_running') ||
      \ has('unix') && system('tput sitm') == "\e[3m")
  let g:noclown_has_italics = 1
endif

if &background == 'dark'
  let s:palette = {
        \ 'foreground' : [250, '#bcbcbc'],
        \ 'background' : [234, '#1c1c1c'],
        \ 'fade'       : [245, '#8a8a8a'],
        \ 'fade_more'  : [238, '#444444'],
        \ 'attention'  : [230, '#ffffd7'],
        \ 'err'        : [203, '#ff5f5f'],
        \}
else
  let s:palette = {
        \ 'attention'  : [250, '#bcbcbc'],
        \ 'foreground' : [234, '#1c1c1c'],
        \ 'fade_more'  : [245, '#8a8a8a'],
        \ 'fade'       : [238, '#444444'],
        \ 'background' : [230, '#ffffd7'],
        \ 'err'        : [203, '#ff5f5f'],
        \}
endif

function! s:fg(name)
  let [ctermfg, guifg] = s:palette[a:name]
  return {'ctermfg': ctermfg, 'guifg': guifg}
endfunction

function! s:bg(name)
  let [ctermbg, guibg] = s:palette[a:name]
  return {'ctermbg': ctermbg, 'guibg': guibg}
endfunction

function! s:attr(...)
  let alist = a:000

  if !exists('g:noclown_has_italics')
    " We're going to modify the list, so make a copy (a:* are immutable)
    let alist = copy(a:000)
    call filter(alist, 'v:val != "italic"')
  endif

  " attrs: comma separated 'alist' as string or if empty: 'NONE'
  let attrs = empty(alist) ? 'NONE' : join(alist, ',')

  return {'term': attrs, 'cterm': attrs, 'gui': attrs}
endfunction

" Clear every attribute to NONE to avoid inheriting from default colorscheme.
let s:hi_clear = {}
for key in ['term', 'cterm', 'ctermfg', 'ctermbg', 'gui', 'guifg', 'guibg']
  let s:hi_clear[key] = 'NONE'
endfor

function! <SID>Defn(group, ...)
  let hi_dict = copy(s:hi_clear)

  " Merge attribute group definitions to main dictionary
  for setting in a:000
    call extend(hi_dict, setting)
  endfor

  let hi_expr = 'highlight ' . a:group  . ' '
  " Convert { k1: v1, k2: v2, ..., kn: vn} dictionary to 'k1=v1 k2=v2 ... kn=vn' string
  let hi_expr .= join(map(items(hi_dict), 'join(v:val, "=")'), ' ')

  execute hi_expr
endfunction

function! <SID>None(group)
  execute 'highlight ' . a:group . ' NONE'
endfunction

function! <SID>Link(from, to)
  call <SID>None(a:from)
  execute 'highlight link ' . a:from . ' ' . a:to
endfunction

" Suggested group names from naming conventions -- ':h E669'
call <SID>Defn('Comment', s:fg('fade'), s:attr('italic'))
call <SID>None('Constant') "<- String Character Number Boolean Float
call <SID>None('Identifier') "<- Function
call <SID>None('Statement') "<- Conditional Repeat Label Operator Keyword Exception
call <SID>None('PreProc') "<- Include Define Macro PreCondit
call <SID>None('Type') "<- StorageClass Structure Typedef
call <SID>None('Special') "<- SpecialChar Tag Delimiter SpecialComment Debug
call <SID>Defn('Underlined', s:attr('underline'))
call <SID>Defn('Ignore', s:fg('fade_more'))
call <SID>Defn('Error', s:fg('err'))
call <SID>Defn('Todo', s:attr('reverse'))

" Default group names -- ':h highlight-default'
call <SID>Defn('Normal', s:fg('foreground'), s:bg('background'))
call <SID>Defn('SpecialKey', s:fg('fade'))
call <SID>Defn('CursorLineNr', s:fg('fade'))
call <SID>Defn('LineNr', s:fg('fade_more'))
call <SID>Defn('VertSplit', s:fg('fade'), s:bg('fade_more'))
call <SID>Link('StatusLineNC', 'VertSplit')
call <SID>Defn('StatusLine', s:attr('bold', 'reverse'))
call <SID>Defn('IncSearch', s:fg('attention'))
call <SID>Defn('Search', s:fg('attention'), s:attr('reverse'))
call <SID>Defn('Title', s:fg('attention'), s:attr('bold')) "titles for output from ':set all', ':autocmd' etc.
call <SID>Defn('Visual', s:attr('reverse'))
call <SID>Defn('ErrorMsg', s:fg('err'))
call <SID>None('CursorLine')
call <SID>Defn('MatchParen', s:attr('reverse'))

""""
""" Unmodified groups from default group names list.
""" They retain their colorscheme from Vim's defaults.
"""
"ColorColumn	used for the columns set with 'colorcolumn'
"Conceal		placeholder characters substituted for concealed
"		text (see 'conceallevel')
"Cursor		the character under the cursor
"CursorIM	like Cursor, but used when in IME mode |CursorIM|
"CursorColumn	the screen column that the cursor is in when 'cursorcolumn' is
"		set
"Directory	directory names (and other special names in listings)
"DiffAdd		diff mode: Added line |diff.txt|
"DiffChange	diff mode: Changed line |diff.txt|
"DiffDelete	diff mode: Deleted line |diff.txt|
"DiffText	diff mode: Changed text within a changed line |diff.txt|
"EndOfBuffer	filler lines (~) after the last line in the buffer.
"		By default, this is highlighted like |hl-NonText|.
"Folded		line used for closed folds
"FoldColumn	'foldcolumn'
"SignColumn	column where |signs| are displayed
"ModeMsg		'showmode' message (e.g., "-- INSERT --")
"MoreMsg		|more-prompt|
"NonText		'@' at the end of the window, characters from 'showbreak'
"		and other characters that do not really exist in the text
"		(e.g., ">" displayed when a double-wide character doesn't
"		fit at the end of the line).
"Pmenu		Popup menu: normal item.
"PmenuSel	Popup menu: selected item.
"PmenuSbar	Popup menu: scrollbar.
"PmenuThumb	Popup menu: Thumb of the scrollbar.
"Question	|hit-enter| prompt and yes/no questions
"SpellBad	Word that is not recognized by the spellchecker. |spell|
"		This will be combined with the highlighting used otherwise.
"SpellCap	Word that should start with a capital. |spell|
"		This will be combined with the highlighting used otherwise.
"SpellLocal	Word that is recognized by the spellchecker as one that is
"		used in another region. |spell|
"		This will be combined with the highlighting used otherwise.
"SpellRare	Word that is recognized by the spellchecker as one that is
"		hardly ever used. |spell|
"		This will be combined with the highlighting used otherwise.
"TabLine		tab pages line, not active tab page label
"TabLineFill	tab pages line, where there are no labels
"TabLineSel	tab pages line, active tab page label
"VisualNOS	Visual mode selection when vim is "Not Owning the Selection".
"		Only X11 Gui's |gui-x11| and |xterm-clipboard| supports this.
"WarningMsg	warning messages
"WildMenu	current match in 'wildmenu' completion
