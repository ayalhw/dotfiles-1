# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="farseerfc" #"powerline" #"farseerfc"
#POWERLINE_RIGHT_A="mixed"
#POWERLINE_SHOW_GIT_ON_RIGHT="true"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git archlinux compleat pip history-substring-search gnu-utils python \
    cp command-not-found)

alias -g colorcopy="| sed 's/'\$(echo -e \"\\033\")'/'\$(echo -e \"\\033\\033\")'/g' | tee /dev/tty | xsel -bi"

DISABLE_AUTO_UPDATE=true
[[ -d ~/.cache/oh-my-zsh ]] || mkdir ~/.cache/oh-my-zsh
ZSH_CACHE_DIR=~/.cache/oh-my-zsh

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/pypy/bin

POWERLINE_BINDINGS=/usr/share/powerline/bindings/

powerline-daemon -q  # run powerline daemon

source $POWERLINE_BINDINGS/zsh/powerline.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# key bindings fixes for urxvt
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[[5~" beginning-of-history
bindkey "^[[6~" end-of-history
bindkey "^[[3~" delete-char
bindkey "^[[2~" quoted-insert

[ -f $HOME/.bashrc ] && source $HOME/.bashrc
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
export SHELL=/bin/zsh

# completion for Syu
compdef -e "words[1]=(pacman -Su);service=pacman;((CURRENT+=1));_pacman" Syu
compdef -e "words[1]=(cower -d);service=cower;((CURRENT+=1));_cower" Ga
compdef -e "words[1]=(cower -s);service=cower;((CURRENT+=1));_cower" Ssa


# added by travis gem
[ -f /home/farseerfc/.travis/travis.sh ] && source /home/farseerfc/.travis/travis.sh

# change systemd-boot default entry to reboot to windows
alias reboot-windows="sudo efivar -w -n 4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderEntryDefault -f =(echo -n 'windows\0' | iconv -f utf-8 -t utf-16le)"

# Automatically change the directory in bash after closing ranger
#
# This is a bash function for .bashrc to automatically change the directory to
# the last visited one after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.

function ranger-cd {
    tempfile="$(mktemp)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

