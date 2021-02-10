#!/bin/bash

# WPI Cloud - wpirock plugins
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

printf "%s${GRN}Displaying:${NC} Primary plugins list from wp.org:\n\n"

# Show primary list of plugins from github
printf "%s${BLU}"
cat <(curl -s -L raw.wpi.pw/wp-plugins/main/primary.yml)
printf "%s${NC}"

# Create array from plugin list
wpi_mapfile plugins <(curl -s -L raw.wpi.pw/wp-plugins/main/primary.yml)

printf "%s\n${GRN}Installing:${NC} Add the plugins to the project? [y/N] "
# shellcheck disable=SC2162
read -n 1 -ep "> " cur_yn

if [[ "$cur_yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  # shellcheck disable=SC2154
  for i in "${!plugins[@]}"; do
    yq w -i "$config_file" "wp-org.[$i].name" "${plugins[$i]}"
  done
else
  printf "\n%s${BRN}Skip:${NC} Primary plugins installing\n"
fi

# Show current config
wpi_show_conf
