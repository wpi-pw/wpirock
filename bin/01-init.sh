#!/bin/bash

# WPI Cloud - wpirock init
# by Dima Minka (https://dima.mk)
# https://cloud.wpi.pw

# Define colors
readonly RED='\033[0;31m'  # error
readonly GRN='\033[0;32m'  # success
#readonly BLU='\033[0;34m' # task
readonly BRN='\033[0;33m'  # headline
readonly NC='\033[0m'      # no color

clear

# TODO: export to source file
function wpi_show_options() {
  # Get options list
  array=("$@")
  for i in "${!array[@]}"; do
    printf "%s${BRN}[$((i+1))]${NC} ${array[$i]}\n"
  done
}

# Set the config dir and name
readonly config_dir="config-wpi" # TODO: move to global var
readonly config_file="$config_dir/$0"

# Create config directory or exit
if [[ -d "$config_dir" ]]; then
  printf "%s${RED}Warning:${NC} $config_dir config exist\n"
  read -r -p "The process will remove $config_file config file! [y/N] " conf_yn
  [[ -z "$conf_yn" || ! "$conf_yn" =~ ^([yY][eE][sS]|[yY])$ ]] && exit
  rm -rf $config_dir # Removing existing directory
  mkdir $config_dir  # Create config directory
else
  mkdir $config_dir  # Create config directory
fi

# Create current config file
touch "$config_file"

# Supported local workflows
arr=('local_wp' 'docker' 'vagrant')

printf "%s${GRN}Installing:${NC} Choose your local development workflow or press Enter for ${BRN}${arr[0]}${NC}:\n\n"

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

# TODO: remove this line when the wpi will be ready
rm -rf config-wpi
