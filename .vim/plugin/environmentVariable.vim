 function! s:pushEnv(shname)
    if a:shname == 'bash'
      let l:envs = split(system('bash -c "source ~/.bashrc; source ~/.bash_profile; export"'))
    elseif a:shname == 'zsh'
      let l:envs = split(system('zsh -c "source ~/.zshrc; source ~/.zshenv; export"'))
    else
      return
    endif

    for l:env in l:envs
      unlet! l:envkeyval
      unlet! l:envkey
      unlet! l:envval
      let l:envkeyval = split(l:env, '=')
      let l:envkey = l:envkeyval[0]
      unlet l:envkeyval[0]
      let l:envval = join(l:envkeyval, '=')

      execute 'let $' . l:envkey . '="' . l:envval . '"'
    endfor
  endfunction
  call s:pushEnv('zsh')
