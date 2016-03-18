
function! NextClosedFold(dir)
  if (foldclosed(line('.')) > 0)
    " normal zo
  else
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, openf] = [0, view.lnum, 1]
    while l != l0 && openf
        exe cmd
        let [l0, l] = [l, line('.')]
        let openf = foldclosed(l) < 0
    endwhile
    if openf
        call winrestview(view)
    endif
    " normal zo
  endif
endfunction

function! CloseFold()
  normal zc
endfunction
" nnoremap <BS> zc
" nnoremap <bar> zc
" nnoremap <silent> <Bslash> :call NextClosedFold('j')<cr>zo
" nnoremap <silent> <C-Bslash> :call NextClosedFold('k')<cr>zo

nnoremap <silent> <Plug>ZipClosed :<C-U>call CloseFold()<cr>
nnoremap <silent> <Plug>ZipOpenNext :<C-U>call NextClosedFold('j')<cr>zo
nnoremap <silent> <Plug>ZipOpenPrev :<C-U>call NextClosedFold('k')<cr>zo

if !hasmapto('<Plug>ZipOpenNext') || maparg('<Bslash>', 'n') ==# ''
  nmap <bar> <Plug>ZipClosed
  nmap <Bslash> <Plug>ZipOpenNext
  nmap <C-Bslash> <Plug>ZipOpenPrev
endif

" nnoremap <bar> zo
" nmap <bar> viizo
"
" nnoremap <Leader>r viizO<Esc>`<zfiik
" nmap <BS> zfiik
" nmap <Bslash> viizo
