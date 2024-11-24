#!/bin/bash

header() {
  local header="$1"
  local len=${#header}
  local border=$(printf "%-${len}s" "" | tr " " "*")

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
    $manager --needed -S ${packages}
  fi
}
