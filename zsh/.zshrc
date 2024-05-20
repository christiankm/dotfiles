# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Environment
export LANG=en_US.UTF-8
export EDITOR='vim'

# Don't clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Hide the "default interactive shell is now zsh" warning on macOS.
export BASH_SILENCE_DEPRECATION_WARNING=1;

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# Add aliases
#
# For a full list of active aliases, run `alias`.
alias reload="source ~/.zshrc"
alias todo="todo.sh"
alias todos="todo.sh list"

# Load rbenv
eval "$(rbenv init - zsh)"

