# PATH configuration and tool initialization

# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# Go binaries
export PATH="$GOPATH/bin:$PATH"

# Local binaries
export PATH="$PATH:$HOME/.local/bin"

# PyEnv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Lazy-load pyenv virtualenv: only initialize when needed
pyenv() {
    unfunction pyenv
    eval "$(command pyenv virtualenv-init -)"
    pyenv "$@"
}

# Volta (Node.js)
export PATH="$VOLTA_HOME/bin:$PATH"

# OpenJDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# FZF shell integration
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh

# ZSH plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Tool initializations
eval "$(starship init zsh)"
RPROMPT=''

