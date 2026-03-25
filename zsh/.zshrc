#!/bin/zsh

# shellcheck disable=SC1090,SC2296

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### USER CONFIGURATION ###

# Update PATH
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Add bin directory to PATH
export PATH="$HOME/bin:$PATH"

# Environment
export LANG=en_US.UTF-8
export EDITOR='vim'
export COLORTERM=1
export HOMEBREW_NO_ENV_HINTS=1
export TODOTXT_DEFAULT_ACTION=ls

# Don't clear the screen after quitting a manual page.
export MANPAGER='less -X'

# Hide the "default interactive shell is now zsh" warning on macOS.
export BASH_SILENCE_DEPRECATION_WARNING=1

# Configure Oh my zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(dotnet fzf gh git git-lfs macos pre-commit swiftpm ruby tmux xcode zsh-syntax-highlighting zsh-autosuggestions)

# Source oh-my-zsh early so plugins and completions are available
source "$ZSH/oh-my-zsh.sh"

# Configure vim/neovim
source "$HOME/.vim/pack/default/start/gruvbox/gruvbox_256palette.sh"

# Source functions
source "$HOME/.dotfiles/bash/functions/task.sh"

# Aliases
source "$HOME/.config/aliases.sh"

# Source any local resources, secret environment variables such as API keys,
# and other things which should never be committed to version control
if [[ -f "$HOME/.config/local/local.sh" ]]; then
  source "$HOME/.config/local/local.sh"
fi

# Load p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
