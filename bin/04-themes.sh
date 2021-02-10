#!/bin/bash

# WPI Cloud - wpirock themes
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

printf "%s${GRN}Installing:${NC} Add Hello Elementor Theme to the project? [y/N] "
# shellcheck disable=SC2162
read -n 1 -ep "> " cur_yn

if [[ "$cur_yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  yq w -i "$config_file" "wp-org.[0].name" "hello-elementor"
else
  printf "\n%s${BRN}Skip:${NC} Hello Elementor theme installing\n"
fi

# Show current config
wpi_show_conf
