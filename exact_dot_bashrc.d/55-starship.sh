# Exit if it's not running in an interactive shell
if [[ "$-" != *i* ]]; then
  return 0 2> /dev/null || exit 0
fi

# Exit if starship is NOT in the PATH
if ! command -v starship &>/dev/null; then
  return 0 2> /dev/null || exit 0
fi

eval "$(starship init bash)"

# Enable transient prompt, powered by ble.sh
if [[ -n "${BLE_VERSION-}" ]]; then
  bleopt prompt_ps1_final='$(starship module character)'
fi
