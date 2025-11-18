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


# iOS/Swift Development aliases
alias fl="bundle exec fastlane"

