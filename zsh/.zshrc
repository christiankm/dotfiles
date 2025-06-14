#!/bin/zsh

# Update $PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Environment
export LANG=en_US.UTF-8
export EDITOR='nvim'

# Don't clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Hide the "default interactive shell is now zsh" warning on macOS.
export BASH_SILENCE_DEPRECATION_WARNING=1;

# Load plugins
plugins=(git macos ruby zsh-syntax-highlighting zsh-autosuggestions)

# Load rbenv
eval "$(rbenv init - zsh)"

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Create aliases
alias reload="source ~/.zshrc"

# Remap vim to use neovim
alias vi="nvim"
alias vim="nvim"

# Git aliases
alias commit="git commit -m "
alias branch="git branch -c "

# Source functions

# ...

# Task and note management
source "$HOME/.dotfiles/bash/functions/task.sh"
alias todo="todo.sh"
alias todos="todo.sh list"
alias todoa="todo.sh a"
alias did="todo.sh -A do"

# BEGIN ANSIBLE MANAGED BLOCK
# Configure Oh my zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="christianmitteldorf"

# Always source oh-my-zsh as the last thing
source $ZSH/oh-my-zsh.sh
# END ANSIBLE MANAGED BLOCK
