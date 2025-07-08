#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Update $PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/opt/homebrew/opt/dotnet@8/bin:$PATH"

# Environment
export LANG=en_US.UTF-8
export EDITOR='vim'
export HOMEBREW_NO_ENV_HINTS=1

# Don't clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Hide the "default interactive shell is now zsh" warning on macOS.
export BASH_SILENCE_DEPRECATION_WARNING=1;

# Configure Oh my zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git macos ruby zsh-syntax-highlighting zsh-autosuggestions)

# Load rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init - zsh)"
fi

# Load nvm
if which nvm > /dev/null; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
fi

# Configure vim/neovim
source "$HOME/.vim/pack/default/start/gruvbox/gruvbox_256palette_osx.sh"


# Remap vim to use neovim
#alias vi="nvim"
#alias vim="nvim"

# Create aliases

# System aliases
alias reload="source ~/.zshrc"
alias see="cat"
alias del="rm"

# Shell aliases
alias ls="ls -l"

# Git and GitHub aliases
alias g="git"
alias gst="git status"
alias gcm="git commit"
alias commit="git commit"
alias gbr="git branch -c "
alias push="git push"
alias pull="git pull --rebase"
alias glg="git log --all --decorate --graph"

alias prs="gh pr list"

# Source functions

# Task and note management
source "$HOME/.dotfiles/bash/functions/task.sh"

alias todo="todo.sh"
alias todos="todo.sh list"
alias t="todo"
alias did="todo.sh do"
alias idea="todo.sh add"

# Always source oh-my-zsh as the last thing
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
