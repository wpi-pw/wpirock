#!/bin/bash

# WPI Cloud - wpirock plugins
# by Dima Minka (https://dima.mk)
# https://cloud.wpi.pw

# Define colors
readonly RED='\033[0;31m' # error
readonly GRN='\033[0;32m' # success
readonly BLU='\033[0;34m' # task
readonly BRN='\033[0;33m' # headline
readonly NC='\033[0m'     # no color

# Set the config dir and name
readonly config_dir="config-wpi" # TODO: move to global var
readonly cur_file_name=${0##*/}
readonly config_file="$config_dir/${cur_file_name%.*}.yml"

# TODO: move to source
# Create array from the external source
function wpi_mapfile() {
    IFS=$'\n' read -d "" -ra $1 < $2
}

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
read -n 1 -ep "> " cur_yn

if [[ "$cur_yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  for i in "${!plugins[@]}"; do
    yq w -i $config_file "wp-org.[$i].name" "${plugins[$i]}"
  done
else
  printf "\n%s${BRN}Skip:${NC} Primary plugins installing\n"
fi

printf "%s\n${GRN}Displaying: ${NC}$config_file\n\n"
yq r "$config_file" -C
printf "\n"

# TODO: remove this line when the wpi will be ready
rm -rf config-wpi
