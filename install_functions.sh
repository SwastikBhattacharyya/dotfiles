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
    "bat"
    "bluez"
    "bluez-utils"
    "brightnessctl"
    "dunst"
    "fastfetch"
    "fd"
    "fish"
    "fzf"
    "fisher"
    "gtk3"
    "hyprland"
    "inter-font"
    "kitty"
    "noto-fonts"
    "noto-fonts-cjk"
    "noto-fonts-emoji"
    "noto-fonts-extra"
    "orchis-theme"
    "papirus-icon-theme"
    "pipewire"
    "pipewire-alsa"
    "pipewire-jack"
    "pipewire-pulse"
    "qt5-wayland"
    "qt6-wayland"
    "rofi-wayland"
    "sddm"
    "ttf-font-awesome"
    "ttf-jetbrains-mono-nerd"
    "ttf-nerd-fonts-symbols"
    "ttf-nerd-fonts-symbols-mono"
    "ttf-roboto-mono-nerd"
    "waybar"
    "wireplumber"
    "xdg-desktop-portal-hyprland"
    "zellij"
  )
  local paru_packages=(
    "bibata-cursor-theme-bin"
    "brave-bin"
    "hyprpolkitagent-git"
    "hyprshot"
    "sddm-astronaut-theme"
    "swww"
    "uwsm"
  )

  install_packages "pacman" "${pacman_packages[*]}"
  install_packages "paru" "${paru_packages[*]}"
}

configure_hyprland() {
  clear
  header "Configuring hyprland"
  systemctl --user enable hyprpolkitagent.service
  systemctl --user start hyprpolkitagent.service
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
    "python38"
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
Requires=swww.service
DefaultDependencies=no

[Service]
ExecStart=/bin/bash /home/${user_home}/.config/swww/swww.sh
Slice=background-graphical.slice
Restart=on-failure
RestartSec=5

[Install]
WantedBy=graphical-session.target
EOF

  systemctl --user daemon-reload
  systemctl --user enable swww.service
  systemctl --user start swww.service
  systemctl --user enable change_wallpaper.service
  systemctl --user start change_wallpaper.service
  systemctl --user enable change_wallpaper.timer
  systemctl --user start change_wallpaper.timer
}

stow_dotfiles() {
  local directories=(
    "dunst"
    "gtk"
    "hyprland"
    "kitty"
    "neovim"
    "rofi"
    "swww"
    "wallpapers"
    "waybar"
    "zellij"
  )

  clear
  header "Stowing dotfiles"
  for directory in "${directories[@]}"; do
    echo "stowing ${directory}"
    stow "${directory}"
  done
}

configure_fish() {
  clear
  header "Configuring fish"

  chsh -s /usr/bin/fish
  chmod +x ./fish_plugins.sh
  ./fish_plugins.sh
}

configure_sddm() {
  local THEME_CONF="/usr/share/sddm/themes/sddm-astronaut-theme/Themes/theme1.conf"

  clear
  header "Configuring SDDM"
  sudo -u root systemctl enable sddm.service
  sudo -u root mkdir -p /etc/sddm.conf.d
  sudo -u root sh -c 'printf "[Theme]\nCurrent=sddm-astronaut-theme\nCursorTheme=Bibata-Modern-Ice\nCursorSize=24\n" >/etc/sddm.conf.d/sddm.conf'
  sudo -u root sh -c 'printf "[Icon Theme]\nInherits=Bibata-Modern-Ice\nCursorSize=24\n" >/usr/share/icons/default/index.theme'

  sudo -u root cp sddm/background.jpg /usr/share/sddm/themes/sddm-astronaut-theme/Backgrounds/

  sudo -u root sed -i 's|Font="Open Sans"|Font="Noto Sans"|g' ${THEME_CONF}
  sudo -u root sed -i 's|HeaderText=""|HeaderText="Welcome to RedStar"|g' ${THEME_CONF}
  sudo -u root sed -i 's|Background="Backgrounds/1.png"|Background="Backgrounds/background.jpg"|g' ${THEME_CONF}
  sudo -u root sed -i 's|DimBackground="0.0"|DimBackground="0.25"|g' ${THEME_CONF}
  sudo -u root sed -i 's|BlurMax=""|BlurMax="32"|g' ${THEME_CONF}
}

configure_bluetooth() {
  clear
  header "Configuring Bluetooth"
  sudo -u root systemctl enable bluetooth.service
  sudo -u root systemctl start bluetooth.service
}
