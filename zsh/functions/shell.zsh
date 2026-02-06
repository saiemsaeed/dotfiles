# Shell utility functions and enhancements

# Prompt spacing enhancement
PROMPT_NEEDS_NEWLINE=false

precmd() {
  if [[ "$PROMPT_NEEDS_NEWLINE" == true ]]; then
    echo
  fi
  PROMPT_NEEDS_NEWLINE=true
  print -Pn "\e]1;${PWD##*/}\a"  # Set the tab title to the current directory name
}

clear() {
  PROMPT_NEEDS_NEWLINE=false
  command clear
}
