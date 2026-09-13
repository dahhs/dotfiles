alias lsd="ls -dl .*"
alias gitgraph="git log --graph --decorate --oneline --all"
alias tsw='tmux switch-client -t'
alias tls='tmux ls'
alias tks='tmux kill-session -t'


eval $(/opt/homebrew/bin/brew shellenv)
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_PROGRESS=1
export TLDR_AUTO_UPDATE_DISABLED=true
export EDITOR=nvim


# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_THEME="geoffgarside"

if [ -z "$TMUX" ]; then
    exec tmux
fi

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

  open -a "Google Chrome" "https://chatgpt.com/?q=$query"
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

