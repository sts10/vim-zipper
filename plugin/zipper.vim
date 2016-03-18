
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

nnoremap <silent> <Plug>ZipClosed :<C-U>call CloseFold()<cr>
nnoremap <silent> <Plug>ZipOpenNext :<C-U>call NextClosedFold('j')<cr>zo
nnoremap <silent> <Plug>ZipOpenPrev :<C-U>call NextClosedFold('k')<cr>zo

if !hasmapto('<Plug>ZipClosed') || maparg('<bar>', 'n') ==# ''
  nmap <bar> <Plug>ZipClosed
endif

if !hasmapto('<Plug>ZipOpenNext') || maparg('<Bslash>', 'n') ==# ''
  nmap <Bslash> <Plug>ZipOpenNext
  nmap <C-Bslash> <Plug>ZipOpenPrev
endif

