# environment variables
## LESS
[ -f /usr/local/bin/src-hilite-lesspipe.sh ]; and set -x LESSOPEN '| /usr/local/bin/src-hilite-lesspipe.sh %s '

# rbenv
if which rbenv > /dev/null
    status --is-interactive; and source (rbenv init -|psub)
end

# nodebrew
[ -d "$HOME/.nodebrew" ]; and set -x PATH $PATH $HOME/.nodebrew/current/bin

# plenv
if [ -d "$HOME/.plenv" ]
    set -x PATH $HOME/.plenv/bin $PATH
    status --is-interactive; and source (plenv init -|psub)
    # status --is-interactive; and source (pyenv virtualenv-init -|psub)
end

# pyenv
if which pyenv > /dev/null
    status --is-interactive; and eval (pyenv init --path)
end

# goenv
if [ -d "$HOME/.goenv" ]
    set -x PATH $HOME/.goenv/bin $PATH
    status --is-interactive; and source (goenv init -|psub)
end

# rust
if [ -d "$HOME/.cargo" ]
    set -x PATH $HOME/.cargo/bin $PATH
end

# sdkman
#[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; and source "$HOME/.sdkman/bin/sdkman-init.sh"

# git highlight
set -x PATH $PATH /usr/local/share/git-core/contrib/diff-highlight

# emacs
function es
    if pgrep -i emacs >/dev/null 2>&1
        echo "Emacs server is already running..."
    else
        which emacs; and emacs --daemon
    end
end
alias ek="emacsclient -e '(kill-emacs)' "
function e
    if not pgrep -i emacs >/dev/null 2>&1
        which emacs >/dev/null 2>&1; and emacs --daemon >/dev/null 2>&1
    else
        emacsclient -t $argv
    end
end
alias ec="open -a Emacs "

# Homebrew
alias bu='brew update; brew upgrade '
set -x HOMEBREW_NO_ANALYTICS 1

# Homebrew cask
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"

# zcat
alias zcat=gzcat

# "このアプリケーションで開く"をクリア
alias clearmenu="cd /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support; and ./lsregister -kill -r -domain system -domain local -domain user; and killall Finder; and cd"
