" Set plugin path
let s:plugins_path = split(&packpath, ',')[0] . '/pack/git-plugins/start'

" Make sure our plugins_path exists
function CheckPluginPath()
    if !isdirectory(s:plugins_path)
        let dirtest = system("mkdir -p " . s:plugins_path)
        echo dirtest
        if dirtest > 0
            echo "oh no!!"
        endif
    endif
endfunction

" Get or Update our Plugins
function GetOrUpdatePlugins()
    call CheckPluginPath()
    for [key, value] in items(g:plugins)
        let s:plugin_path = s:plugins_path . "/" . key
        if !isdirectory(s:plugin_path)
            let clone_ret = system("git clone " . value . " " . s:plugin_path)
            echo clone_ret
        else
            let cur_dir = getcwd()
            echo s:plugin_path
            let pull_ret = system("pushd " . s:plugin_path . ";git pull; popd")
            echo pull_ret
        endif
    endfor
    " Reload the vimrc
    load-vim-script $MYVIMRC
endfunction
