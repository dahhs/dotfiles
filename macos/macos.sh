#!/bin bash

# Mouse Acceleration defaults is 0.6875
# run: 'defaults read -g com.apple.mouse.scaling' to check it.

defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0
killall Dock

defaults write NSGlobalDomain InitialKeyRepeat -int 11
defaults write NSGlobalDomain KeyRepeat -int 1

defaults write -g NSWindowResizeTime -float 0.001


# 關閉部分 AppKit 捲動視圖的「橡皮筋回彈（rubber banding）」效果
defaults write -g NSScrollViewRubberbanding -int 0 
# defaults delete -g NSScrollViewRubberbanding # 取消該設定

# 關閉 macOS AppKit App 的部分自動視窗動畫，讓視窗出現、消失等操作直接完成。e.g. Finder Preview etc.
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
# defaults delete -g NSAutomaticWindowAnimationsEnabled


defaults write -g NSScrollAnimationEnabled -bool false
# defaults delete -g NSScrollAnimationEnabled


# 把 Quick Look 預覽面板的動畫時間設為 0 秒。
defaults write -g QLPanelAnimationDuration -float 0

defaults write -g NSToolbarFullScreenAnimationDuration -float 0

defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0

defaults write com.apple.finder DisableAllAnimations -bool true

defaults write NSGlobalDomain NSWindowResizeTime 0.001

