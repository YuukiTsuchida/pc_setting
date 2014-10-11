if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetScalaIndent()

setlocal indentkeys=0{,0},0),!^F,<>>,<CR>,o,O

setlocal autoindent sw=4 et

if exists("*GetScalaIndent")
  finish
endif

function! CountParens(line)
  let line = substitute(a:line, '"\(\\"\|[^"]\)*"', '', 'g')
  let open = substitute(line, '[^(]', '', 'g')
  let close = substitute(line, '[^)]', '', 'g')
  return strlen(open) - strlen(close)
endfunction

function! ExtractBraces(line)
  let line = substitute(a:line, '"\(\\"\|[^"]\)*"', '', 'g')
  let line = substitute(line, '[^{}]', '', 'g')
  let result = []
  for i in range(strlen(line)-1, 0, -1)
    call add(result, line[i])
  endfor
  return result
endfunction

function! IsStartOneLineBlock(line)
  if a:line =~ '^\s*\(\(else\s\+\)\?if\|for\|while\).*)\s*$'
        \ || a:line =~ '^\s*\(override\s\+\|private\(\[[^\]]\+\]\)\?\s\+\|protected\(\[[^\]]\+\]\)\?\s\+\)*\(\(lazy\s\+\)\?val\|var\|def\).*=\s*$'
        \ || a:line =~ '\(\s\|}\)else\s*$'
    return 1
  endif
  return 0
endfunction

function! IsStartBlock(line)
  let list = ExtractBraces(a:line)
  if len(list) > 0 && list[0] == '{'
    return 1
  endif
  return 0
endfunction

function! GetPrevNonBlankAndLine(lnum)
  let prevlnum = prevnonblank(a:lnum)
  let prevline = getline(prevlnum)
  return [prevlnum, prevline]
endfunction

function! GetPrevOpenBraceLineNumber(lnum)
  let braceCount = 0
  let prevlnum = a:lnum
  whil 1
    if prevlnum <= 0
      return 0
    endif
    let [prevlnum, prevline] = GetPrevNonBlankAndLine(prevlnum)
    let braceList = ExtractBraces(prevline)
    for brace in braceList
      if brace == "{"
        let braceCount += 1
      elseif brace == "}"
        let braceCount -= 1
      endif
      if(braceCount > 0)
        return prevlnum
      endif
    endfor
    let prevlnum -= 1
  endwhile
endfunction

function! IsCasePattern(line)
  if a:line !~ '\<case\>\s\+\<class\>' && a:line =~ '^\s*case\s\+.\+\s\+=>.*$'
    return 1
  else
    return 0
  endif
endfunction

function! GetScalaIndent()

  let thisline = getline(v:lnum)
  let [prevlnum, prevline] = GetPrevNonBlankAndLine(v:lnum - 1)
  let ind = indent(prevlnum)

  " Hit the start of the file, use zero indent.
  if prevlnum == 0
    return 0
  endif

  "Indent html literals
  if prevline !~ '/>\s*$' && prevline =~ '^\s*<[a-zA-Z][^>]*>\s*$'
    return ind + &shiftwidth
  endif

  if thisline =~ '^\s*</[a-zA-Z][^>]*>'
    return ind - &shiftwidth
  endif

  " Add a 'shiftwidth' after lines that start a block
  " If if, for or while end with ), this is a one-line block
  " If val, var, def end with =, this is a one-line block
  if IsStartOneLineBlock(prevline) || IsStartBlock(prevline)
    return ind + &shiftwidth
  endif

  " If parenthesis are unbalanced, indent or dedent
  let c = CountParens(prevline)
  if c > 0
    return ind + &shiftwidth
  elseif c < 0
    return ind - &shiftwidth
  endif

  " Align 'for' clauses nicely
  if prevline =~ '^\s*for (.*;\s*$'
    return ind - &shiftwidth + 5
  endif

  " Subtract a 'shiftwidth' on '}'
  if thisline =~ '^\s*}'
    let lnum = GetPrevOpenBraceLineNumber(prevlnum)
    echo lnum."|".getline(lnum)
    return indent(lnum)
  endif

  " case
  if IsCasePattern(thisline)
    while 1
      if prevlnum <= 0
        return 0
      endif
      let [prevlnum, prevline] = GetPrevNonBlankAndLine(prevlnum)
      if IsCasePattern(prevline)
        return indent(prevlnum)
      endif
      let prevlnum -= 1
    endwhile
  endif

  if IsCasePattern(prevline)
    return ind + &shiftwidth
  endif

  " Dedent after if, for, while and val, var, def without block
  if prevline =~ '^\s*}\s*$'
    let prevlnum = GetPrevOpenBraceLineNumber(prevlnum - 1)
  endif
  while 1
    let [prevlnum, prevline] = GetPrevNonBlankAndLine(prevlnum - 1)
    if IsStartOneLineBlock(prevline)
      let ind = indent(prevlnum)
    else
      break
    endif
  endwhile

  return ind
endfunction
