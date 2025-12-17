#!/bin/bash

# System aliases
alias reload="source $HOME/.zshrc"
alias see="cat"
alias del="rm"

# Filesystem and navigation aliases
alias ls="ls -CGp"
alias ll="ls -lAhtGtpc --color=auto"
alias ..="cd ../"
alias ...="cd ../.."

# Override standard commands with default flags
alias rm="rm -i"
alias cp="cp -i"
alias grep="grep --color=auto"

# Navigation and Directories
alias bin="cd $HOME/.local/bin"
alias dotfiles="cd $HOME/.dotfiles"
alias dev="cd $HOME/Developer"
alias scripts="cd $HOME/scripts"

# Git aliases
alias g="git"
alias gs="git status"
alias gst="git status"
alias gc="git commit"
alias gcm="git commit"
alias commit="git commit"
alias gbr="git branch -c "
alias push="git push"
alias pull="git pull --rebase"
alias glog="git log --all --decorate --graph"

# GitHub aliases
alias prs="gh pr list"

# iOS/Swift Development aliases
alias fl="bundle exec fastlane"
alias delder="rm -rf ~/Library/Developer/Xcode/DerivedData/"

# Task and note management
alias today="cal && todo.sh list"
alias task="todo.sh add"
alias tasks="todo.sh list"
alias todo="todo.sh"
alias todos="todo.sh list"
alias t="todo.sh"
alias did="todo.sh do"
alias done="todo.sh done"
alias report="todo.sh report"
alias due="todo.sh list --allduedates"
