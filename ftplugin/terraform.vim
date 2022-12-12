command! -nargs=* Terradoc call s:terradoc(<f-args>)
command! TerradocClean
      \ terminal ++shell ++close find /tmp/terradoc/* -maxdepth 0 -exec rm -rf {} \;
