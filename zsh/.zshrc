# Update $PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Configure Oh my zsh
# Set ZSH theme
ZSH_THEME="robbyrussell"
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
HIST_STAMPS="dd/mm/yyyy"

# Environment
export LANG=en_US.UTF-8
export EDITOR='vim'

# Don't clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Hide the "default interactive shell is now zsh" warning on macOS.
export BASH_SILENCE_DEPRECATION_WARNING=1;

# Load plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# Add aliases
#
# For a full list of active aliases, run `alias`.
alias reload="source ~/.zshrc"
alias todo="todo.sh"
alias todos="todo.sh list"
alias todoa="todo.sh a"
alias did="todo.sh -A do"

alias flutter=~/flutter_3.10.3/bin/flutter

# Load rbenv
eval "$(rbenv init - zsh)"