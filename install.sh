#!/bin/bash

source ./install_functions.sh

check_paru_install
install_preliminary_packages
install_required_packages
install_dev_packages
configure_dev_packages
