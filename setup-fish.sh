#!/bin/bash

DOT_FILES=( .gitconfig .tmux.conf .dir_colors .gemrc .git_templates .gitignore_global )

for file in ${DOT_FILES[@]}
do
    ( [ -s $HOME/$file ] || [ -d $HOME/$file ] )  || ln -s `pwd`/$file $HOME/$file
done

case "${OSTYPE}" in
    # Mac(Unix)
    darwin*)
    [ ! -d $HOME/.config ] && mkdir -p $HOME/.config
    [ ! -d $HOME/.config/peco ] && ln -s `pwd`/.config/peco $HOME/.config/peco
    [ ! -d $HOME/.config ] && ln -sf `pwd`/fish $HOME/.config/fish

    # imgcatのダウンロード
    curl -sfL -o /usr/local/bin/imgcat https://raw.github.com/gnachman/iTerm2/master/tests/imgcat -O && chmod +x /usr/local/bin/imgcat
    ;;
    # Linux
    linux*)
    [ ! -d $HOME/.config ] && mkdir -p $HOME/.config
    [ ! -d $HOME/.config/peco ] && ln -s `pwd`/.config/peco $HOME/.config/peco
    [ ! -d $HOME/.config ] && ln -sf `pwd`/fish $HOME/.config/fish
    ;;
esac

# fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman

# gitのセットアップ
./setup-git.sh

# zsh reload
[ -s /usr/local/bin/fish ] && exec /usr/local/bin/fish -l
[ -s /usr/bin/fish ] && exec /usr/bin/fish -l
