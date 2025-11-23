" ~/.config/nvim/colors/nord-darker.vim
" Nord Darker colorscheme based on Alacritty nord-darker.toml

" Clear existing highlights
highlight clear
if exists("syntax_on")
  syntax reset
endif

" Set colorscheme name
let g:colors_name = "nord-darker"

" Set true color support
set termguicolors

" Define Nord Darker palette from nord-darker.toml
let s:bg = "#21252D"      " Primary background
let s:fg = "#D8DEE9"      " Primary foreground
let s:cursor = "#D8DEE9"  " Cursor
let s:cursor_bg = "#21252D"  " Cursor background
let s:selection_bg = "#88C0D0"  " Selection background (working color for visibility)
let s:selection_fg = "#21252D"  " Selection text (working color for visibility)
let s:black = "#2E333F"   " Normal black
let s:red = "#BF616A"     " Normal red (errors)
let s:green = "#A3BE8C"   " Normal green (strings)
let s:yellow = "#EBCB8B"  " Normal yellow (constants)
let s:blue = "#88C0D0"    " Normal blue (keywords)
let s:magenta = "#B48EAD"  " Normal magenta
let s:cyan = "#8FBCBB"    " Normal cyan
let s:white = "#D8DEE9"   " Normal white
let s:bright_black = "#434C5E"  " Bright black (disabled)
let s:bright_red = "#BF616A"    " Bright red
let s:bright_green = "#A3BE8C"  " Bright green
let s:bright_yellow = "#EBCB8B" " Bright yellow
let s:bright_blue = "#81A1C1"   " Bright blue
let s:bright_magenta = "#B48EAD"  " Bright magenta
let s:bright_cyan = "#8FBCBB"   " Bright cyan
let s:bright_white = "#ECEFF4"  " Bright white
let s:orange = "#D08770"  " Indexed orange (warnings)

" Set terminal colors for Neovim
if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = [
        \ s:black, s:red, s:green, s:yellow, s:blue, s:magenta, s:cyan, s:white,
        \ s:bright_black, s:bright_red, s:bright_green, s:bright_yellow,
        \ s:bright_blue, s:bright_magenta, s:bright_cyan, s:bright_white
        \ ]
  for i in range(len(g:terminal_ansi_colors))
    let g:terminal_color_{i} = g:terminal_ansi_colors[i]
  endfor
endif

" Basic UI highlights
execute 'hi Normal guibg=' . s:bg . ' guifg=' . s:fg
execute 'hi Cursor guibg=' . s:cursor . ' guifg=' . s:cursor_bg
execute 'hi Visual guibg=' . s:selection_bg . ' guifg=' . s:selection_fg
execute 'hi VisualNOS guibg=' . s:selection_bg . ' guifg=' . s:selection_fg . ' gui=underline'
execute 'hi CursorLine guibg=' . s:black
execute 'hi CursorColumn guibg=' . s:black
execute 'hi LineNr guifg=' . s:bright_black . ' guibg=' . s:bg
execute 'hi CursorLineNr guifg=' . s:bright_blue . ' guibg=' . s:bg
execute 'hi NonText guifg=' . s:bright_black
execute 'hi SpecialKey guifg=' . s:bright_black
execute 'hi StatusLine guibg=' . s:bright_black . ' guifg=' . s:fg
execute 'hi StatusLineNC guibg=' . s:bright_black . ' guifg=' . s:bright_black
execute 'hi VertSplit guibg=' . s:bg . ' guifg=' . s:bright_black
execute 'hi MatchParen guibg=' . s:selection_bg . ' guifg=' . s:selection_fg

" Syntax highlighting
execute 'hi Comment guifg=' . s:bright_blue
execute 'hi String guifg=' . s:green
execute 'hi Number guifg=' . s:yellow
execute 'hi Keyword guifg=' . s:blue
execute 'hi Identifier guifg=' . s:white
execute 'hi Function guifg=' . s:cyan
execute 'hi Constant guifg=' . s:yellow
execute 'hi Statement guifg=' . s:blue
execute 'hi Type guifg=' . s:blue
execute 'hi Special guifg=' . s:magenta
execute 'hi PreProc guifg=' . s:magenta
execute 'hi Error guifg=' . s:red . ' guibg=NONE'
execute 'hi Todo guifg=' . s:orange . ' guibg=NONE'
execute 'hi WarningMsg guifg=' . s:orange

" Diff highlighting
execute 'hi DiffAdd guibg=' . s:green . ' guifg=' . s:bg
execute 'hi DiffChange guibg=' . s:yellow . ' guifg=' . s:bg
execute 'hi DiffDelete guibg=' . s:red . ' guifg=' . s:bg
execute 'hi DiffText guibg=' . s:orange . ' guifg=' . s:bg

" Cterm colors for 256-color terminals
if &t_Co >= 256
  hi Normal ctermfg=254 ctermbg=235 cterm=NONE
  hi Cursor ctermfg=235 ctermbg=254 cterm=NONE
  hi Visual ctermfg=235 ctermbg=110 cterm=reverse
  hi VisualNOS ctermfg=235 ctermbg=110 cterm=reverse,underline
  hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=237 cterm=NONE
  hi LineNr ctermfg=239 ctermbg=235 cterm=NONE
  hi CursorLineNr ctermfg=109 ctermbg=235 cterm=NONE
  hi NonText ctermfg=239 ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=239 ctermbg=NONE cterm=NONE
  hi StatusLine ctermfg=254 ctermbg=239 cterm=NONE
  hi StatusLineNC ctermfg=239 ctermbg=239 cterm=NONE
  hi VertSplit ctermfg=239 ctermbg=235 cterm=NONE
  hi MatchParen ctermfg=109 ctermbg=235 cterm=reverse
  hi Comment ctermfg=109 ctermbg=NONE cterm=NONE
  hi String ctermfg=144 ctermbg=NONE cterm=NONE
  hi Number ctermfg=186 ctermbg=NONE cterm=NONE
  hi Keyword ctermfg=110 ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=254 ctermbg=NONE cterm=NONE
  hi Function ctermfg=109 ctermbg=NONE cterm=NONE
  hi Constant ctermfg=186 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=110 ctermbg=NONE cterm=NONE
  hi Type ctermfg=110 ctermbg=NONE cterm=NONE
  hi Special ctermfg=139 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=139 ctermbg=NONE cterm=NONE
  hi Error ctermfg=131 ctermbg=NONE cterm=reverse
  hi Todo ctermfg=173 ctermbg=NONE cterm=reverse
  hi WarningMsg ctermfg=173 ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=235 ctermbg=144 cterm=NONE
  hi DiffChange ctermfg=235 ctermbg=186 cterm=NONE
  hi DiffDelete ctermfg=235 ctermbg=131 cterm=NONE
  hi DiffText ctermfg=235 ctermbg=173 cterm=NONE
endif

" Color definitions for template
" Background: dark
" Color: white         #D8DEE9           254               lightgray
" Color: black         #2E333F           237               darkgray
" Color: diffc         #88C0D0           110               blue
" Color: difft         #81A1C1           109               blue
" Color: cursorl       #2E333F           237               darkgray
" Color: nord_bg       #21252D           235               black
" Color: nord_fg       #D8DEE9           254               lightgray
" Color: nord_selection_bg #434C5E       239               darkgray
" Color: nord_selection_fg #81A1C1       109               blue
" Color: nord_red      #BF616A           131               red
" Color: nord_green    #A3BE8C           144               green
" Color: nord_yellow   #EBCB8B           186               yellow
" Color: nord_blue     #88C0D0           110               blue
" Color: nord_magenta  #B48EAD           139               magenta
" Color: nord_cyan     #8FBCBB           109               cyan
" Color: nord_bright_black #434C5E       239               darkgray
" Color: nord_bright_white #ECEFF4       255               white
" Color: nord_orange   #D08770           173               red
" vim: et ts=2 sw=2 sts=2
