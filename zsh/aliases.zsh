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


# AO function - updates ZTOKEN from ztoken script and runs opencode
function dr() {
    export ZTOKEN=$(ztoken)
    droid
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

alias cpr="gh pr create --web"

# NIC - splits current Ghostty window into: vim (left) | opencode (top-right) / empty (bottom-right)
function nic() {
    local dir="${1:-$PWD}"
    local ztoken="$(ztoken)"
    osascript - "$dir" "$ztoken" <<'APPLESCRIPT'
on run argv
    set workDir to item 1 of argv
    set ztokenVal to item 2 of argv
    tell application "Ghostty"
        set currentTab to selected tab of window 1
        set leftPane to terminal 1 of currentTab

        set cfg to new surface configuration
        set initial working directory of cfg to workDir

        set cfgOC to new surface configuration from cfg
        set command of cfgOC to "zsh -l -c 'ZTOKEN=" & ztokenVal & " opencode'"

        set rightPane to split leftPane direction right with configuration cfgOC
        split rightPane direction down with configuration cfg

        input text "nvim" to leftPane
        send key "enter" to leftPane

        focus rightPane
    end tell
end run
APPLESCRIPT
}

