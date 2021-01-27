#!/bin/bash

# WPI Cloud - wpirock init
# by Dima Minka (https://dima.mk)
# https://cloud.wpi.pw

clear

# Default vars
config_dir=""
config_file=""

# Load cloud source scripts
# shellcheck disable=SC1090
case "${@: -1}" in
  --cloud | -c) source <(curl -s raw.wpi.pw/wpirock/master/bin/00-source.sh);;
  *)            source "${PWD}"/bin/00-source.sh;; # Load local source scripts
esac

printf "%s${GRN}Installing:${NC} Connect WPIRock to the new app or existing one? [Y/n] "
# shellcheck disable=SC2162
read -n 1 -ep "> " cur_yn
[[ -n "$cur_yn" && ! "$cur_yn" =~ ^([yY][eE][sS]|[yY])$ ]] && exit

# Create config directory or exit
if [[ -d "$config_dir" ]]; then
  printf "%s\n${RED}Warning:${NC} $config_dir config exist\n"
  read -r -p "The process will remove $config_dir config file! [y/N] " conf_yn
  [[ -z "$conf_yn" || ! "$conf_yn" =~ ^([yY][eE][sS]|[yY])$ ]] && exit
  rm -rf "$config_dir" # Removing existing directory
  mkdir "$config_dir"  # Create config directory
else
  mkdir "$config_dir"  # Create config directory
fi

# Create current config file
touch "$config_file"

# Supported local workflows
arr=('local_wp' 'docker' 'vagrant')

printf "%s\n${GRN}Installing:${NC} Choose your local development workflow or press Enter for ${BRN}${arr[0]}${NC}:\n\n"

# Display options list
wpi_show_options "${arr[@]}"

# shellcheck disable=SC2162
read -n 1 -ep "> " cur_option

# Create config items or print error message
if [[ -n "$cur_option" && "$cur_option" != 1 ]]; then
  printf "%s\n${RED}Warning:${NC} Workflow not supported yet\n\n"
else
# Set default init variables
  yq w -i "$config_file"  'local_workflow' 'local_wp'
  yq w -i "$config_file"  'must_use' 'false'
  yq w -i "$config_file"  'plugins' 'true'
  yq w -i "$config_file"  'settings' 'true'
  yq w -i "$config_file"  'themes' 'true'
  yq w -i "$config_file"  'wordpress_version' 'latest'

  printf "%s\n${GRN}Displaying: ${NC}$config_file\n\n"
  yq r "$config_file" -C
  printf "\n"
fi
