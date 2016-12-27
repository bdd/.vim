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


let s:foreground = 250 "Grey74 - #bcbcbc
let s:background = 234 "Grey11 - #1c1c1c
let s:fade       = 245 "Grey54 - #8a8a8a
let s:fade_more  = 238 "Grey27 - #444444
let s:attention  = 230 "Cornsilk1 - #ffffd7
let s:red        = 203 "IndianRed1 - #ff5f5f

set background=dark

highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = "noclown"

function! <SID>Defn(group, fg, bg, attr)
  let c = {'fg': a:fg, 'bg': a:bg, 'attr': a:attr}
  for k in keys(c)
    if c[k] == "" | let c[k] = "NONE" | endif
  endfor

  exec "highlight "
    \ . a:group
    \ . " term=" . c['attr']
    \ . " cterm=" . c['attr'] . " ctermfg=" . c['fg'] . " ctermbg=" . c['bg']
endfunction

function! <SID>None(...)
  for group in a:000
    execute "highlight " . group . " NONE"
  endfor
endfunction

function! <SID>Link(from, to)
  call <SID>None(a:from)
  execute "highlight link " . a:from . " " . a:to
endfunction


" Suggested group names from naming conventions -- ':h E669'
call <SID>Defn("Comment", s:fade, "", "italic")
call <SID>None("Constant") "<- String Character Number Boolean Float
call <SID>None("Identifier") "<- Function
call <SID>None("Statement") "<- Conditional Repeat Label Operator Keyword Exception
call <SID>None("PreProc") "<- Include Define Macro PreCondit
call <SID>None("Type") "<- StorageClass Structure Typedef
call <SID>None("Special") "<- SpecialChar Tag Delimiter SpecialComment Debug
call <SID>Defn("Underlined", "", "", "underline")
call <SID>Defn("Ignore", s:fade_more, "", "")
call <SID>Defn("Error", s:red, "", "")
call <SID>Defn("Todo", "", "", "reverse")

" Default group names -- ':h highlight-default'
call <SID>Defn("Normal", s:foreground, s:background, "")
call <SID>Defn("CursorLineNr", s:fade, "", "")
call <SID>Defn("LineNr", s:fade_more, "", "")
call <SID>Link("SpecialKey", "LineNr") "unprintable chars like 'listchars'
call <SID>Defn("VertSplit", s:fade, s:fade_more, "")
call <SID>Link("StatusLineNC", "VertSplit")
call <SID>Defn("StatusLine", "", "", "bold,reverse")
call <SID>Defn("IncSearch", s:attention, "", "")
call <SID>Defn("Search", s:attention, "", "reverse")
call <SID>Defn("Title", s:attention, "", "bold") "titles for output from ':set all', ':autocmd' etc.  
call <SID>Defn("Visual", "", "", "reverse")
call <SID>Defn("ErrorMsg", s:red, "", "")
call <SID>None("CursorLine")
call <SID>Defn("MatchParen", "", "", "reverse")

""""
""" Unmodified groups from default group names list.
""" They retain their colorscheme from Vim's default for 'background=dark'.
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
