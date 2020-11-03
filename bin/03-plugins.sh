#!/bin/bash

# WPI Cloud - wpirock
# by Dima Minka (https://dima.mk)
# https://cloud.wpi.pw

# Define colors
#readonly RED='\033[0;31m' # error
readonly GRN='\033[0;32m' # success
readonly BLU='\033[0;34m' # task
readonly BRN='\033[0;33m' # headline
readonly NC='\033[0m'     # no color

# Set the config name
readonly config_dir="config-wpi"

# Set init config path
config="$config_dir/03-plugins.yml"
touch $config

printf "%s${GRN}Displaying:${NC} Primary plugins list from wp.org:\n"
# Show primary list of plugins from github
cat <(curl -s -L raw.wpi.pw/wp-plugins/main/primary.yml)
# Create array from plugins list
mapfile -t plugins < <(curl -s -L raw.wpi.pw/wp-plugins/main/primary.yml)

printf "%s${GRN}Installing:${NC} Add to the project? "
read -r -p "[y/N] " conf_yn

if [[ "$conf_yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  for i in "${!plugins[@]}"; do
    yq w -i $config "wp-org.[$i].name" "${plugins[$i]}"
  done
else
  printf "%s${BRN}Skip:${NC} Primary plugins installing\n"
fi

printf "\n"

printf "%s${GRN}Installing:${NC} Add a plugin from bitbucket to the project? "
read -r -p "[y/N] " conf_yn

if [[ "$conf_yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  printf "%s${GRN}Setup:${NC} Enter a plugin workspace/repo-name:\n"
  read -r -p "> " conf_value
  yq w -i $config "bitbucket.[0].name" "$conf_value"
  printf "%sThe repo is https://bitbucket.org/${BLU}$conf_value${NC}.git\n\n"
  printf "%s${GRN}Setup:${NC} Enter oauth key:\n"
  read -r -p "> " conf_value
  yq w -i $config "bitbucket.[0].setup" "oauth"
  yq w -i "$config_dir/01-init.yml" "setup.oauth.bitbucket.key" "$conf_value"
  printf "%s${GRN}Setup:${NC} Enter oauth secret:\n"
  read -r -p "> " conf_value
  yq w -i "$config_dir/01-init.yml" "setup.oauth.bitbucket.secret" "$conf_value"
else
  printf "%s${BRN}Skip:${NC} Bitbucket plugins installing\n"
fi

printf "\n"

printf "%s${GRN}Installing:${NC} Add a must-use plugin URL? "
read -r -p "[y/N] " conf_yn

if [[ "$conf_yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  printf "%s${GRN}Setup:${NC} Enter a php file URL:\n\n"
  read -r -p "> " conf_value
  yq w -i $config "must_use.[0]" "$conf_value"
else
  printf "%s${BRN}Skip:${NC} Must-use plugins installing\n"
fi

printf "%s\n${GRN}Displaying: ${NC}$config\n"
yq r $config -C
printf "\n"
