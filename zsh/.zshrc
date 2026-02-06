# zmodload zsh/zprof
# Oh My Zsh plugins configuration
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

# Load modular configuration files
for config in ~/dotfiles/zsh/{exports.zsh,aliases.zsh,config/*.zsh,functions/*.zsh}; do
  [[ -r "$config" ]] && source "$config"
done


# zprof

export LOUNGE_LOCAL_CERTIFICATE=/Users/sasaeed/code/zalando/zl-skipper/tools/proxy/_wildcard.local.zlounge.org.pem
export LOUNGE_LOCAL_CERTIFICATE_KEY=/Users/sasaeed/code/zalando/zl-skipper/tools/proxy/_wildcard.local.zlounge.org-key.pem

# opencode
export PATH=/Users/sasaeed/.opencode/bin:$PATH

# bun completions
[ -s "/Users/saiemsaeed/.bun/_bun" ] && source "/Users/saiemsaeed/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1

export LOUNGE_LOCAL_CERTIFICATE=/Users/saiemsaeed/code/zalando/zl-skipper/tools/proxy/_wildcard.local.zlounge.org.pem
export LOUNGE_LOCAL_CERTIFICATE_KEY=/Users/saiemsaeed/code/zalando/zl-skipper/tools/proxy/_wildcard.local.zlounge.org-key.pem

set_tab_title() {
    local title="${PWD##*/}"  # Get the current directory name
    echo -ne "\033]0;${title}\007"  # Set the terminal title
}

# Call the function before each prompt
precmd_functions+=(set_tab_title)

export LG_CONFIG_FILE="/Users/saiemsaeed/.config/lazygit/config.yaml"

