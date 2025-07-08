#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Update $PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Environment
export LANG=en_US.UTF-8
#export EDITOR='nvim'
export EDITOR='vim'

# Don't clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Hide the "default interactive shell is now zsh" warning on macOS.
export BASH_SILENCE_DEPRECATION_WARNING=1;

# Configure Oh my zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git macos ruby zsh-syntax-highlighting zsh-autosuggestions)

# Load rbenv
eval "$(rbenv init - zsh)"

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Create aliases
alias reload="source ~/.zshrc"

# Configure vim/neovim
source "$HOME/.vim/pack/default/start/gruvbox/gruvbox_256palette_osx.sh"

# Remap vim to use neovim
#alias vi="nvim"
#alias vim="nvim"

# Source functions

# ...

# Task and note management
source "$HOME/.dotfiles/bash/functions/task.sh"
alias todo="todo.sh"
alias todos="todo.sh list"
alias todoa="todo.sh a"
alias did="todo.sh -A do"


# Always source oh-my-zsh as the last thing
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
