#!/bin/bash

# WPI Cloud - wpirock source
# by Dima Minka (https://dima.mk)
# https://cloud.wpi.pw

# Define colors
readonly RED='\033[0;31m'  # error
readonly GRN='\033[0;32m'  # success
readonly BLU='\033[0;34m' # task
readonly BRN='\033[0;33m'  # headline
readonly NC='\033[0m'      # no color

# Set the config dir and name
readonly config_dir="config-wpi"
readonly cur_file_name=${0##*/}
readonly config_file="$config_dir/${cur_file_name%.*}.yml"

# Options print from array
function wpi_show_options() {
  # Get options list
  array=("$@")
  for i in "${!array[@]}"; do
    printf "%s${BRN}[$((i+1))]${NC} ${array[$i]}\n"
  done
}
