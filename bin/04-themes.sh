#!/bin/bash

# WPI Cloud - wpirock themes
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
config="$config_dir/04-themes.yml"
touch $config

printf "%s${GRN}Installing:${NC} Add Hello Elementor Theme to the project? "
read -r -p "[y/N] " conf_yn

if [[ "$conf_yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  yq w -i $config "wp-org.[0].name" "hello-elementor"
else
  printf "%s${BRN}Skip:${NC} Hello Elementor theme installing\n"
fi

printf "\n"

printf "%s${GRN}Installing:${NC} Add a theme from bitbucket to the project? "
read -r -p "[y/N] " conf_yn

if [[ "$conf_yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  printf "%s${GRN}Setup:${NC} Enter a theme workspace/repo-name:\n"
  read -r -p "> " conf_value
  yq w -i $config "bitbucket.[0].name" "$conf_value"
  printf "%sThe repo is https://bitbucket.org/${BLU}$conf_value${NC}.git\n\n"
  printf "%s${GRN}Setup:${NC} Enter oauth key:\n"
  read -r -p "> " conf_value
  yq w -i $config "bitbucket.[0].setup" "oauth_themes"
  yq w -i "$config_dir/01-init.yml" "setup.oauth_themes.bitbucket.key" "$conf_value"
  printf "%s${GRN}Setup:${NC} Enter oauth secret:\n"
  read -r -p "> " conf_value
  yq w -i "$config_dir/01-init.yml" "setup.oauth_themes.bitbucket.secret" "$conf_value"
else
  printf "%s${BRN}Skip:${NC} Bitbucket themes installing\n"
fi

printf "\n"

printf "%s\n${GRN}Displaying: ${NC}$config\n"
yq r $config -C
printf "\n"
