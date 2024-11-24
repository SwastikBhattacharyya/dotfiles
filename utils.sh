#!/bin/bash

header() {
  local header="$1"
  local len=${#header}
  local border
  border=$(printf "%-${len}s" "" | tr " " "*")

  echo "${border}"
  echo "${header}"
  echo "${border}"
}

install_packages() {
  local manager="$1"
  local packages="$2"

  if [[ "${manager}" == "pacman" ]]; then
    manager="sudo -u root ${manager}"
  fi

  if [ -n "${packages}" ]; then
    for package in ${packages}; do
      if ! ${manager} -Qi "${package}" >/dev/null; then
        echo "Installing ${package}"
        ${manager} -S "${package}"
      else
        echo "${package} is already installed"
      fi
    done
  fi
}
