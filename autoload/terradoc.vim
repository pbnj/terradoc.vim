" don't spam the user when Vim is started in Vi compatibility mode
let s:cpo_save = &cpo
set cpo&vim

function! s:terradoc(
      \ author = 'hashicorp',
      \ provider = 'aws',
      \ refs = 'heads',
      \ version = 'main'
      \ ) abort

  let l:download_dir_prefix = '/tmp/terradoc/'.a:author
  let l:download_dir = 'terraform-provider-'.a:provider.'/'.a:version

  if !isdirectory(l:download_dir_prefix.'/'.l:download_dir)
    let l:cmd_curl = printf('curl --location --create-dirs --output "%s/%s.zip" "https://github.com/%s/terraform-provider-%s/archive/refs/%s/%s.zip"',
          \ l:download_dir_prefix,
          \ l:download_dir,
          \ a:author,
          \ a:provider,
          \ a:refs,
          \ a:version
          \ )

    let l:cmd_unzip = printf('unzip "%s/%s.zip" */docs/* -d "%s/%s"',
          \ l:download_dir_prefix,
          \ l:download_dir,
          \ l:download_dir_prefix,
          \ l:download_dir
          \ )

    echom l:cmd_curl
    call system(l:cmd_curl)

    echom l:cmd_unzip
    call system(l:cmd_unzip)

    if exists(':Rg')
      execute ':cd '.l:download_dir_prefix.'/'.l:download_dir
      Rg
    else
      execute ':Explore '.l:download_dir_prefix.'/'.l:download_dir
    endif

  else

    if exists(':Rg')
      execute ':cd '.l:download_dir_prefix.'/'.l:download_dir
      Rg
    else
      execute ':Explore '.l:download_dir_prefix.'/'.l:download_dir
    endif

  endif
endfunction

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save
