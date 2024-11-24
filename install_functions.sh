#!/usr/bin/bash

source ./utils.sh

check_paru_install() {
  clear
  header "Checking for paru installation"
  if pacman -Qi "paru" >/dev/null; then
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
    "papirus-icon-theme"
    "pipewire"
    "pipewire-pulse"
    "rofi-wayland"
    "ttf-jetbrains-mono-nerd"
    "wireplumber"
  )
  local paru_packages=(
    "brave-bin"
    "swww"
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
    "markdownlint-cli"
    "nodejs"
    "npm"
    "prettier"
    "python-isort"
    "python-black"
    "rustup"
    "shfmt"
    "stylelint-config-standard"
    "stylua"
    "taplo-cli"
  )
  local paru_packages=(
    "cmake-format"
    "google-java-format"
    "prettierd"
    "sqlfmt-bin"
  )

  clear
  header "Installing development packages"

  install_packages "pacman" "${pacman_packages[@]}"
  install_packages "paru" "${paru_packages[@]}"
}

configure_dev_packages() {
  clear
  header "Configuring development packages"
  rustup default stable
}

configure_swww() {
  local user_home
  user_home=$(whoami)

  clear
  header "Configuring swww"
  chmod +x ./swww/.config/swww/swww.sh

  cat <<EOF >./swww/.config/systemd/user/change_wallpaper.service
[Unit]
Description=Change wallpaper
After=swww.service

[Service]
ExecStart=/bin/bash /home/${user_home}/.config/swww/swww.sh

[Install]
WantedBy=default.target
EOF

  systemctl --user daemon-reload
  systemctl --user enable swww.service
  systemctl --user start swww.service
  systemctl --user enable change_wallpaper.service
  systemctl --user start change_wallpaper.service
  systemctl --user enable change_wallpaper.timer
  systemctl --user start change_wallpaper.timer
}
