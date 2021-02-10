#!/bin/bash

# WPI Cloud - wpirock init
# by Dima Minka (https://dima.mk)
# https://cloud.wpi.pw

# Define colors
readonly RED='\033[0;31m' # error
readonly GRN='\033[0;32m' # success
#readonly BLU='\033[0;34m' # task
#readonly BRN='\033[0;33m' # headline
readonly NC='\033[0m'     # no color

# Set the config name
readonly config_dir="config-wpi"

if [[ -d "$config_dir" ]]; then
  printf "%s${RED}Warning:${NC} $config_dir config exist\n"
  read -r -p "The process will remove $config config file! [y/N] " conf_yn
  [[ -z "$conf_yn" || "$conf_yn" =~ ^([nN][oO]|[nN])$ ]] && exit
  rm -rf $config_dir    # Removing existing directory
  mkdir $config_dir # Create config directory
else
  mkdir $config_dir # Create config directory
fi

# Set init config path
config="$config_dir/01-init.yml"
touch $config

# Set default init variables
yq w -i $config  'wordpress_version' 'latest'
yq w -i $config  'plugins' 'true'
yq w -i $config  'must_use' 'true'
yq w -i $config  'themes' 'true'
yq w -i $config  'settings' 'true'

printf "%s\n${GRN}Displaying: ${NC}$config\n"
yq r $config -C
printf "\n"
