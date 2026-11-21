#!/bin/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ -f "$HOME/.config/local/.zprofile" ]]; then
  source "$HOME/.config/local/.zprofile"
fi
