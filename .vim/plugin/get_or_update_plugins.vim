" Get or Update our Plugins
function GetOrUpdatePlugins()
  " Save current directory
  let s:current_dir = getcwd()
  if exists("g:plugins")
    " Set plugin path
    let s:plugins_path = split(&packpath, ',')[0] . '/pack/git-plugins/start'
    " Make sure our plugins_path exists
    if !isdirectory(s:plugins_path)
      echo system('mkdir -p ' . s:plugins_path)
    endif
    " For each item(key, value) in g:plugins
    for [key, value] in items(g:plugins)
      let s:plugin_path = s:plugins_path . '/' . key
      if !isdirectory(s:plugin_path)
        " Clone if the plugin doesn't exist
        echo 'Cloning ' . value . ' to '. s:plugin_path
        echo system('git clone ' . value . ' ' . s:plugin_path)
      else
        " Update the plugin if it does exist
        echo 'Updating ' . s:plugin_path . ' from ' . value
        execute 'cd ' . s:plugin_path
        echo system('git pull --all --tags --prune --stat')
      endif
      " Return to the current directory
      execute "cd " . s:current_dir
    endfor
    " Reload the vimrc
    source $MYVIMRC
  endif
endfunction
