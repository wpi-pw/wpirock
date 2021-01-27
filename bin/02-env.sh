#!/bin/bash

# WPI Cloud - wpirock env
# by Dima Minka (https://dima.mk)
# https://cloud.wpi.pw

# Define colors
#readonly RED='\033[0;31m' # error
readonly GRN='\033[0;32m' # success
readonly BLU='\033[0;34m' # task
readonly BRN='\033[0;33m' # headline
readonly NC='\033[0m'     # no color

printf "%s${GRN}Configuring:${NC} Inserting env details to config\n\n"

# Set the config dir and name
readonly config_dir="config-wpi" # TODO: move to global var
readonly cur_file_name=${0##*/}
readonly config_file="$config_dir/${cur_file_name%.*}.yml"

# Create current config file
touch "$config_file"

yq w -i $config_file  "wir_test.app_ip" 127.0.0.1
yq w -i $config_file  "wir_test.app_noindex" "true"
yq w -i $config_file  "wir_test.app_path" ""
yq w -i $config_file  "wir_test.app_protocol" ""
yq w -i $config_file  "wir_test.app_user" "cdk"

yq w -i $config_file  "wir_test.db_name" "local"
yq w -i $config_file  "wir_test.db_user" "root"
yq w -i $config_file  "wir_test.db_pass" "root"
yq w -i $config_file  "wir_test.db_prefix" "wp_wpi_"

yq w -i $config_file  "wir_test.wp_environment_type" "development"
yq w -i $config_file  "wir_test.wp_home" "wir.test"

printf "%s${GRN}Displaying: ${NC}$config_file\n\n"
yq r "$config_file" -C
printf "\n"
