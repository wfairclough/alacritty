#!/bin/bash
# Check if Alacritty is installed and select the correct config file based on platform
#

CONFIG_FILE="$HOME/.config/alacritty/alacritty.toml"

print_install_instructions_and_exit() {
  echo "Alacritty is not installed. Please install it from: https://alacritty.org/"
  exit 1
}

# If macOS, use the macOS config file
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ ! -f "/Applications/Alacritty.app/Contents/MacOS/alacritty" ]]; then
    print_install_instructions_and_exit
  fi 
  echo "macOS detected. Using macOS config file."
  unlink "$CONFIG_FILE" || true
  ln -sf "$PWD/alacritty.macos.toml" "$HOME/.config/alacritty/alacritty.toml"
  exit 0
fi

# If Linux, use the Linux config file
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if [[ ! -x "$(command -v alacritty)" ]]; then
    print_install_instructions_and_exit
  fi 
  echo "Linux detected. Using Linux config file."
  unlink "$CONFIG_FILE" || true
  ln -sf "$PWD/alacritty.linux.toml" "$HOME/.config/alacritty/alacritty.toml"
  exit 0
fi

