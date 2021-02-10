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

# Set the config name
readonly config_dir="config-wpi"

# Set env config path
config="$config_dir/02-env.yml"
current_env=""
printf "%s${GRN}Configuration:${NC} Setup $config config\n"
touch $config

# Prepare init vars
def_args=(
  wpi.test
  root
  root
  password
  localhost
  wp_wpi_
  development
  https
  true
)
app_args=(
  wp_home
  db_name
  db_user
  db_pass
  db_host
  db_prefix
  wp_environment_type
  app_protocol
  app_noindex
)
for i in "${!app_args[@]}"; do
  cur_a=""
  cur_option=""
  message=""
  options=()
  override="true"

  # args helper for config overrides
  case "${app_args[$i]}" in
    wp_environment_type) message=true; override=""; options=(development staging production);;
    app_protocol) message=true; override=""; options=(https http);;
    app_noindex) message=true; override=""; options=(true false);;
    *);;
  esac

  if [[ -n "$override" ]]; then
    # Override default values
    printf "%s\n${GRN}Setup:${NC}"
    printf "%s Enter new value to change the ${BLU}${app_args[$i]}${NC} or press ENTER for ${BRN}${def_args[$i]}${NC}:\n"
    read -r -p "> " cur_a
  fi

  # Default app details if new not exist
  [[ -z "$cur_a" ]] && cur_a=${def_args[$i]}

  # Set the value from options list
  if [[ -n "$message" ]]; then
    # Check if value exist in the options list
    while [[ ! ${cur_option} =~ ^[0-9]+$ ]]; do
        printf "%s\n${GRN}Setup:${NC}"
        printf "%s Choose the value for ${BLU}${app_args[$i]}${NC} from the list:\n"
        # Gat options list
        for o in "${!options[@]}"; do
          echo "[$((o+1))] ${options[$o]}"
        done
        # shellcheck disable=SC2162
        read -n 1 -ep "> " cur_option
        ! [[ ${cur_option} -ge 1 && ${cur_option} -le ${#options[@]}  ]] && unset cur_option
    done
    # Set value to current variable
    cur_a=${options[$((cur_option-1))]}
  fi

  # Current config key
  [[ "${app_args[$i]}" == "wp_home" ]] && current_env="${cur_a//./_}"
  cur_key="$current_env.${app_args[$i]}"
  # Write data to config
  yq w -i $config "$cur_key" "$cur_a"
  printf "%sThe variable is - ${BLU}${app_args[$i]}: ${BRN}$cur_a${NC}\n"
done

# Default env variables
yq w -i $config  "$current_env.app_ip" 127.0.0.1
yq w -i $config  "$current_env.app_user" 'wpi'
yq w -i $config  "$current_env.app_path" "/var/www/$(yq r $config "$current_env".wp_home)"

printf "%s\n${GRN}Displaying: ${NC}$config\n"
yq r $config -C "$current_env"
printf "\n"
