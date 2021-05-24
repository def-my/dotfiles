# environment variables
## LESS
[ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; and set -x LESSOPEN '| /usr/share/source-highlight/src-hilite-lesspipe.sh %s '

# rbenv
if [ -d "$HOME/.rbenv" ]
    set -x PATH $HOME/.rbenv/bin $PATH
    status --is-interactive; and source (rbenv init -|psub)
end

# nodebrew
[ -d "$HOME/.nodebrew" ]; and set -x PATH $HOME/.nodebrew/current/bin $PATH

# plenv
if [ -d "$HOME/.plenv" ]
    set -x PATH $HOME/.plenv/bin $PATH
    status --is-interactive; and source (plenv init -|psub)
    status --is-interactive; and source (pyenv virtualenv-init -|psub)
end

# pyenv
if [ -d "$HOME/.pyenv" ]
    set -x PATH $HOME/.pyenv/bin $PATH
    status --is-interactive; and eval (pyenv init --path)
end

# goenv
if [ -d "$HOME/.goenv" ]
    set -x PATH $HOME/.goenv/bin $PATH
    status --is-interactive; and source (goenv init -|psub)
end

# golang
if which go > /dev/null
    [ ! -d "$HOME/.golang" ]; and mkdir -p "$HOME/.golang/bin"
    set -x GOPATH $HOME/.golang
    set -x PATH $GOPATH/bin $PATH
end

# rust
if [ -d "$HOME/.cargo" ]
    set -x PATH $HOME/.cargo/bin $PATH
end

#sdkman
#[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; and source "$HOME/.sdkman/bin/sdkman-init.sh"

# git highlight
[ -d /usr/share/doc/git/contrib/diff-highlight ]; and set -x PATH /usr/share/doc/git/contrib/diff-highlight $PATH

# alias
alias open=xdg-open

# emacs
function es
    if pgrep emacs >/dev/null 2>&1
        echo "Emacs server is already running..."
    else
        which emacs; and emacs --daemon
    end
end
alias ek="emacsclient -e '(kill-emacs)' "
function e
    if not pgrep emacs >/dev/null 2>&1
        which emacs >/dev/null 2>&1; and emacs --daemon >/dev/null 2>&1
    fi
        emacsclient -t $argv
    end
end
function ec
  emacsclient -c $argv[1] &
end
