" Get or Update our Plugins
function GetOrUpdatePlugins()
  " Set plugin path
  let s:plugins_path = split(&packpath, ',')[0] . '/pack/git-plugins/start'
  " Make sure our plugins_path exists
  if !isdirectory(s:plugins_path)
    let s:mkdir_path_ret = system('mkdir -p ' . s:plugins_path)
    echo s:mkdir_path_ret
  endif
  for [key, value] in items(g:plugins)
    let s:plugin_path = s:plugins_path . '/' . key
    if !isdirectory(s:plugin_path)
      let s:clone_out = system('git clone ' . value . ' ' . s:plugin_path)
      echo s:clone_out
    else
      let s:pull_ret = system('pushd ' . s:plugin_path . ';git pull; popd')
      echo s:pull_ret
    endif
  endfor
  " Reload the vimrc
  source $MYVIMRC
endfunction
