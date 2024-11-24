#!/usr/bin/bash

source ./utils.sh

check_paru_install() {
  clear
  header "Checking for paru installation"
  if pacman -Qi "paru" > /dev/null
  then
    echo "paru is installed on your system"
  else
    echo "This install script requires paru to be the AUR helper of your system. Please uninstall your current AUR helper and install paru on your system."
    exit 1
  fi
}

install_preliminary_packages() {
  local packages=(
    "git"
    "git-lfs"
    "lazygit"
    "stow"
  )

  clear
  header "Installing preliminary packages"
  install_packages "pacman" "${packages[*]}"
}

install_required_packages() {
  local pacman_packages=(
    "gtk3"
    "hyprland"
    "kitty"
    "pipewire"
    "pipewire-pulse"
    "wireplumber"
  )
  local paru_packages=(
    "zen-browser-bin"
  )

  install_packages "pacman" "${pacman_packages[*]}"
  install_packages "paru" "${paru_packages[*]}"
}

install_dev_packages() {
  local pacman_packages=(
    "clang"
    "jdk17-openjdk"
    "lib32-clang"
    "luarocks"
    "nodejs"
    "npm"
    "prettier"
    "python-isort"
    "python-black"
    "rustup"
    "stylelint-config-standard"
    "stylua"
    "taplo-cli"
  )
  local paru_packages=(
    "beautysh"
    "cmake-format"
    "google-java-format"
    "prettierd"
    "sqlfmt-bin"
  )

  clear
  header "Installing development packages"

  install_packages "pacman" "${pacman_packages[*]}"
  install_packages "paru" "${paru_packages[*]}"
}

configure_dev_packages() {
  clear
  header "Configuring development packages"
  rustup default stable
}
