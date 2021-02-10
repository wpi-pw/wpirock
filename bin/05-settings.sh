#!/bin/bash

# WPI Cloud - wpirock settings
# by Dima Minka (https://dima.mk)
# https://cloud.wpi.pw

# Default vars
config_file=""

# Load cloud source scripts
# shellcheck disable=SC1090
case "${@: -1}" in
  --cloud | -c) source <(curl -s raw.wpi.pw/wpirock/master/bin/00-source.sh);;
  *)            source "${PWD}"/bin/00-source.sh;; # Load local source scripts
esac

# Create current config file
touch "$config_file"

printf "%s${GRN}Displaying:${NC} Primary settings list:\n\n"
# Show primary list of settings from github
yq r <(curl -s -L raw.wpi.pw/wp-settings/main/primary.yml) -C

printf "\n%s${GRN}Installing:${NC} Add settings to the project? [y/N] "
# shellcheck disable=SC2162
read -n 1 -ep "> " cur_yn

if [[ "$cur_yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  cat <(curl -s -L raw.wpi.pw/wp-settings/main/primary.yml) > "$config_file"
else
  printf "%s${BRN}Skip:${NC} Primary settings installing\n"
fi

# Show current config
wpi_show_conf
