# Lines configured by zsh-newuser-install
export ZSH="$HOME/.oh-my-zsh"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/flo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#eval "$(oh-my-posh init zsh --config ~/.dotfiles/themes/catppuccin_mocha.omp.json)"
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml

source ~/.dots/eldritch/colors.sh

# Load Angular CLI autocompletion.
source <(ng completion script)
export EDITOR=nvim
#export PATH=/home/flo/.spicetify:$HOME/.tmuxifier/bin:$PATH
export LUAROCKS_LUA_BIN=/usr/bin/lua5.1


export PATH="$HOME/.tmuxifier/bin:$PATH"
#export ANDROID_HOME=$HOME/android-sdk
#export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$PATH
#export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$HOME/.local/bin
alias v="nvim"
#alias y="yazi"
alias stow="stow -d ~/.dots"




eval "$(tmuxifier init -)"
export QT_QPA_PLATFORM=xcb


alias f="fzf --preview '[[ -f {} ]] && bat --style=numbers --color=always --line-range=:100 {}'"





export FZF_CTRL_T_OPTS="
--preview 'bat -n --color=always {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Use :: as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='::'

# Eldritch Colorscheme / theme
# https://github.com/eldritch-theme/fzf
# FZF Plugin
export FZF_DEFAULT_OPTS="--color=fg:#ebfafa,bg:${BACKGROUND},hl:#37f499 \
--color=fg+:#ebfafa,bg+:#212337,hl+:#37f499 \
--color=info:#f7c67f,prompt:#04d1f9,pointer:#7081d0 \
--color=marker:#7081d0,spinner:#f7c67f,header:#323449"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}



. "$HOME/.local/bin/env"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use)

source $ZSH/oh-my-zsh.sh
