" Markdown syntax file
" Use conceal to show checkboxes for Markdown task lists

setlocal conceallevel=2

"if has('conceal')
"    if &termencoding ==# "utf-8" || &encoding ==# "utf-8"
        let s:checkbox_unchecked = "\u2610"
        let s:checkbox_checked = "\u2612"
        let s:checkbox_dotted = "\u2613"
        let s:checkbox_dashed = "\u1111"
        "    else
"        let s:checkbox_unchecked = 'o'
"        let s:checkbox_checked = 'x'
"        let s:checkbox_dotted = '.'
"    endif
"
"    syntax match markdownCheckbox "^\s*\([-\*] \[[ x]\]\|--\|++\) " contains=markdownCheckboxChecked,markdownCheckboxUnchecked,markdownCheckboxDotted
"
"    execute 'syntax match markdownCheckboxUnchecked "" contained conceal cchar='.s:checkbox_unchecked
"    # ---- Checked
"    # --- Dotted
"endif

syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=☐
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[x\]'hs=e-4 conceal cchar=☑
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[-\]'hs=e-4 conceal cchar=☒
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=➔

hi def link todoCheckbox Todo

highlight Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
