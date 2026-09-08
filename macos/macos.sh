#!/bin bash

# Mouse Acceleration defaults is 0.6875
# run: 'defaults read -g com.apple.mouse.scaling' to check it.

defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.45
killall Dock

defaults write NSGlobalDomain InitialKeyRepeat -int 11
defaults write NSGlobalDomain KeyRepeat -int 1
