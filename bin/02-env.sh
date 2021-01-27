#!/bin/bash

# WPI Cloud - wpirock env
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

printf "%s${GRN}Configuring:${NC} Inserting env details to config\n\n"

# Create current config file
touch "$config_file"

yq w -i "$config_file"  "wir_test.app_ip" 127.0.0.1
yq w -i "$config_file"  "wir_test.app_noindex" "true"
yq w -i "$config_file"  "wir_test.app_path" ""
yq w -i "$config_file"  "wir_test.app_protocol" ""
yq w -i "$config_file"  "wir_test.app_user" "cdk"

yq w -i "$config_file"  "wir_test.db_name" "local"
yq w -i "$config_file"  "wir_test.db_user" "root"
yq w -i "$config_file"  "wir_test.db_pass" "root"
yq w -i "$config_file"  "wir_test.db_prefix" "wp_wpi_"

yq w -i "$config_file"  "wir_test.wp_environment_type" "development"
yq w -i "$config_file"  "wir_test.wp_home" "wir.test"

printf "%s${GRN}Displaying: ${NC}$config_file\n\n"
yq r "$config_file" -C
printf "\n"
