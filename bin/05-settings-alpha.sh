#!/bin/bash

# WPI Cloud - wpirock settings
# by Dima Minka (https://dima.mk)
# https://cloud.wpi.pw

# Define colors
#readonly RED='\033[0;31m' # error
readonly GRN='\033[0;32m' # success
readonly BRN='\033[0;33m' # headline
readonly NC='\033[0m'     # no color

# Set the config name
readonly config_dir="config-wpi"

# Set init config path
config="$config_dir/05-settings.yml"
touch $config

printf "%s${GRN}Displaying:${NC} Primary settings list:\n"
# Show primary list of settings from github
yq r <(curl -s -L raw.wpi.pw/wp-settings/main/primary.yml) -C

printf "%s${GRN}Installing:${NC} Add settings to the project? [y/N] "
read -r -p "[y/N] " conf_yn

if [[ "$conf_yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  cat <(curl -s -L raw.wpi.pw/wp-settings/main/primary.yml) > $config
else
  printf "%s${BRN}Skip:${NC} Primary settings installing\n"
fi

printf "%s\n${GRN}Displaying: ${NC}$config\n"
yq r $config -C
printf "\n"
