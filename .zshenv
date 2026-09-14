export SHELL_SESSIONS_DISABLE=1

export HOMEBREW_NO_AUTO_UPDATE=1

export ZDOTDIR="$HOME/.config/zsh"

export HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# .zshrc, etc. are located here
if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
    export ZDOTDIR=~/.config/zsh
fi

. "$HOME/.cargo/env"
