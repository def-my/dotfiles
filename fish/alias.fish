## use colordiff
alias diff=colordiff

## less
alias less='less -RMI '

## lv
#alias lv='lv -c -Au8 '

## tree
alias t1='tree -L 1'
alias t2='tree -L 2'
alias t3='tree -L 3'

## simple server(require python3)
function server
    python -m http.server $argv
end

function safe-rm
    if test "$argv[1]" = "-rf"; or test "$argv[1]" = "-fr"
        echo "$PWD"
        echo "rm $argv"
        sleep 5
    end
    /bin/rm $argv
end
alias rm=safe-rm

## extract
function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xvjf $argv[1]
            case '*.tar.gz'
                tar xvzf $argv[1]
            case '*.tar.xz'
                tar xvJf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xvf $argv[1]
            case '*.tbz2'
                tar xvjf $argv[1]
            case '*.tgz'
                tar xvzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*.lzma'
                lzma -dv $argv[1]
            case '*.xz'
                xz -dv $argv[1]
            case '*'
                echo "don't know how to extract $argv[1]..."
        end
    else
        echo "$argv[1] is not a valid file!"
    end
end
alias ex=extract

## ghq
function ghq-update
    ghq list | grep github | sed -E 's/^[^\/]+\/(.+)/\1/' | xargs -n 1 -P 10 ghq get -u
end

## chpwd
function chpwd --on-variable PWD
    set -l cursor_pos (commandline --cursor)
    # Only show directory listing in interactive mode when not tab completing
    if test $cursor_pos -eq 0 ;and status --is-interactive
        ll
    end
end

function __show_current_dir_and_git_status
    ls
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1
        echo
        echo (set_color yellow)"--- git status ---"(set_color normal)
        git status -sb
    end
end

function done_enter
    if test -z (commandline)
        echo
        __show_current_dir_and_git_status
    else
        commandline -f execute
    end
    commandline -f repaint
end
