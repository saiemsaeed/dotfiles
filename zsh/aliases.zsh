# Command aliases and shortcuts

# Editor aliases
alias vim="nvim"
alias vi="nvim"

# Git aliases
# alias lg="lazygit"
alias gco="git checkout"
alias gl="git log --oneline --graph --decorate --all"
alias gpo="git push origin"
alias gcm="git commit -m"
alias gwl="git worktree list"

# Zoxide
if [ -z "$DISABLE_ZOXIDE" ]; then
    eval "$(zoxide init --cmd cd zsh)"
fi

#AI 
alias ai="claude"
alias cld="claude --dangerously-skip-permissions"

# AO function - updates ZTOKEN from ztoken script and runs opencode
function oc() {
    export ZTOKEN=$(ztoken)
    opencode
}

function lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# Script runner
alias ss="run_scripts"

