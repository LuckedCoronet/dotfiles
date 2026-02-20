# Exit if it's not running in an interactive shell
if [[ "$-" != *i* ]]; then
  return 0 2> /dev/null || exit 0
fi

# Exit if ble.sh is not found
if [[ ! -f ~/.local/share/blesh/ble.sh ]]; then
  return 0 2> /dev/null || exit 0
fi

source ~/.local/share/blesh/ble.sh

# Disable unnecessary ble.sh features
bleopt highlight_syntax=
bleopt highlight_filename=
bleopt highlight_variable=
bleopt complete_auto_complete=
bleopt complete_auto_history=
bleopt complete_auto_menu=
bleopt exec_errexit_mark=
bleopt exec_elapsed_mark=
bleopt prompt_eol_mark=
