# 隨時刪除這些設定
# export VULKAN_SDK=$HOME/Projects/capstone-project/VulkanSDK/1.4.335.0
# export PATH=$VULKAN_SDK/macOS/bin:$PATH
# export DYLD_LIBRARY_PATH=$VULKAN_SDK/macOS/lib:$DYLD_LIBRARY_PATH

eval $(/opt/homebrew/bin/brew shellenv)
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_PROGRESS=1
export TLDR_AUTO_UPDATE_DISABLED=true

export EDITOR=nvim
alias lsd="ls -dl .*"
alias gitgraph="git log --graph --decorate --oneline --all"


export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"

# 可在命令行中直接運行llvm相關的工具，如clang、clang++等，
# 而不必輸入完整的路徑(預設是/usr/bin/clang會先被使用)
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/binutils/lib"
export CPPFLAGS="-I/opt/homebrew/opt/binutils/include"

# export PYDEVD_DISABLE_FILE_VALIDATION=1 # 作用: 關閉 pydevd（Python 除錯器）的檔案驗證機制。

# 參考資料：https://ixyzero.com/blog/archives/2840.html
export C_INCLUDE_PATH=/opt/homebrew/include/:$C_INCLUDEPATH # no use 'include/SDL2'
export C_INCLUDE_PATH=/opt/homebrew/Cellar/glfw/3.4/include/:$C_INCLUDE_PATH
export C_INCLUDE_PATH=/Users/dah/Learning/openGL/glad/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/Users/dah/Learning/openGL/glad/include:$CPLUS_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/opt/homebrew/Cellar/open-mpi/5.0.3_1/include:$C_INCLUDE_PATH  
# export CPLUS_INCLUDE_PATH=/opt/homebrew/include/SDL2:$CPLUS_INCLUDE_PATH     
# export C_INCLUDE_PATH=/opt/homebrew/include/:$C_INCLUDE_PATH             

# 使得編譯命令不需加上 -L/opt/homebrew/lib
# 將該路徑設定至環境變數，使得作業系統會先去指定路徑底下找，找不到就去系統路徑
export LIBRARY_PATH=/opt/homebrew/lib:$LIBRARY_PATH
export LIBRARY_PATH=/opt/homebrew/Cellar/glfw/3.4/lib:$LIBRARY_PATH

if [ -z "$TMUX" ]; then
    tmux # exec tmux / exec arch -arm64 tmux
fi

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

# zsh-autosuggest config
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_THEME="geoffgarside"

if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=""
  ZSH_THEME=""
fi

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

function cfgzsh() {
  nvim ~/.config/zsh/.zshrc
}

function cfgnvim() {
  cd ~/.config/nvim
  nvim init.lua
}


# NOTE: URL 裡的空白不能直接使用，所以需要 URL encoding，將字串解析成能用的
# 字串中的特殊字元轉成 URL 可以安全表示的形式。%20 在 URL 中代表「空格」字元
# python3 -c '...' 直接執行後面的 Python 程式碼，不需建立 .py 檔。
function goog() {
  open -a "Google Chrome" \
    "https://www.google.com/search?q=$(python3 -c '
      import urllib.parse, sys
      print(urllib.parse.quote(" ".join(sys.argv[1:])))' "$@")"
}


function ai() {
  local query
  if (( $# > 0 )); then
    query=$(python3 -c '
      import sys, urllib.parse
      print(urllib.parse.quote(" ".join(sys.argv[1:])))' "$@"
    )
  else
    query=$(pbpaste | python3 -c '
      import sys, urllib.parse
      print(urllib.parse.quote(sys.stdin.read()))'
    )
  fi

  open -a "Google Chrome" \
    "https://chatgpt.com/?q=$query"
}


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# NOTE: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
# The incantation typeset -U path, where the -U stands for unique,
# tells the shell that it should not add anything to $path if it's
# there already.
typeset -U path

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

