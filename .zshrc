#####################################################################
#
#  Sample .zshrc file
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read.
#
#####################################################################

###
# Set Shell variable
# WORDCHARS=$WORDCHARS:s,/,,
HISTSIZE=200 HISTFILE=~/.zhistory SAVEHIST=180

## Default shell configuration
#
# set prompt
# colors enables us to idenfity color by $fg[red].
autoload colors
colors
case ${UID} in
    0)
        PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
        PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
        SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
          PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
        ;;
    *)
        #
        # Color
        #
        DEFAULT=$'%{\e[1;0m%}'
        RESET="%{${reset_color}%}"
        #GREEN=$'%{\e[1;32m%}'
        GREEN="%{${fg[green]}%}"
        #BLUE=$'%{\e[1;35m%}'
        BLUE="%{${fg[blue]}%}"
        RED="%{${fg[red]}%}"
        CYAN="%{${fg[cyan]}%}"
        WHITE="%{${fg[white]}%}"
        #
        # Prompt
        #
        setopt prompt_subst
        #PROMPT='${fg[white]}%(5~,%-2~/.../%2~,%~)% ${RED} $ ${RESET}'
        PROMPT='${RESET}${GREEN}${WINDOW:+"[$WINDOW]"}${RESET}%{$fg_bold[blue]%}${USER}@%m${RESET}${WHITE}$ ${RESET}'
        RPROMPT='${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)% ${WHITE}]${WINDOW:+"[$WINDOW]"} ${RESET}'

        # ľ���Υ��ޥ�ɤν�λ���ơ�������0�ʳ��ΤȤ����֤����롣
        # ${MY_MY_PROMPT_COLOR}��precmd���Ѳ������Ƥ�����͡�
        local MY_COLOR="$ESCX"'%(0?.${MY_PROMPT_COLOR}.31)'m
        local NORMAL_COLOR="$ESCX"m

        # Show git branch when you are in git repository
        # http://d.hatena.ne.jp/mollifier/20100906/p1
        autoload -Uz add-zsh-hook
        autoload -Uz vcs_info

        zstyle ':vcs_info:*' enable git svn hg bzr
        zstyle ':vcs_info:*' formats '(%s)-[%b]'
        zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
        zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
        zstyle ':vcs_info:bzr:*' use-simple true

        autoload -Uz is-at-least
        if is-at-least 4.3.10; then
        # ���� check-for-changes ����������ꤹ��Ȥ���
            zstyle ':vcs_info:git:*' check-for-changes true
            zstyle ':vcs_info:git:*' stagedstr "+"    # Ŭ����ʸ������ѹ�����
            zstyle ':vcs_info:git:*' unstagedstr "-"  # Ŭ����ʸ������ѹ�����
            zstyle ':vcs_info:git:*' formats '(%s)-[%b%c%u]'
            zstyle ':vcs_info:git:*' actionformats '(%s)-[%b%c%u|%a]'
        fi

        function _update_vcs_info_msg() {
            psvar=()
            LANG=en_US.UTF-8 vcs_info
            psvar[2]=$(_git_not_pushed)
            [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
        }
        add-zsh-hook precmd _update_vcs_info_msg

        function _git_not_pushed()
        {
            if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
                head="$(git rev-parse HEAD)"
                for x in $(git rev-parse --remotes)
                do
                    if [ "$head" = "$x" ]; then
                        return 0
                    fi
                done
                echo "{?}"
            fi
            return 0
        }

        RPROMPT="%1(v|%F${CYAN}%1v%2v%f|)${vcs_info_git_pushed}${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)% ${WHITE}]${WINDOW:+"[$WINDOW]"} ${RESET}"
        ;;
esac

# Set shell options
# ͭ���ˤ��Ƥ���Τ������Ѥξ��ʤ����
setopt auto_cd auto_remove_slash auto_name_dirs 
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys pushd_ignore_dups
# �������������Ѥζ�����Τϥ����ȥ�����
#setopt auto_menu  correct rm_star_silent sun_keyboard_hack
#setopt share_history inc_append_history

# binding keys
bindkey -e
#bindkey '^p'	history-beginning-search-backward
#bindkey '^n'	history-beginning-search-forward

# �䴰�����ƥ������: �䴰�ε�ư��ʬ����䤹���ʤ�2�Ĥ�����Τߵ���
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
autoload -U compinit && compinit

# perlbrew
source ~/.perlbrew/etc/bashrc

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# alias����ե�������ɤ߹���
[ -f ~/dotfiles/.zshrc.alias ] && source ~/dotfiles/.zshrc.alias

# OS�������
case "${OSTYPE}" in
    # Mac(Unix)
    darwin*)
    # ����������
    [ -f ~/dotfiles/.zshrc.osx ] && source ~/dotfiles/.zshrc.osx
    ;;
    # Linux
    linux*)
    # ����������
    [ -f ~/dotfiles/.zshrc.linux ] && source ~/dotfiles/.zshrc.linux
    ;;
esac
