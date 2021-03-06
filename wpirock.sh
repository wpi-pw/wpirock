#!/bin/bash

# WPI Cloud - wpirock
# by Dima Minka (https://dima.mk)
# https://cloud.wpi.pw

# Load cloud source scripts
# shellcheck disable=SC1090
case "${@: -1}" in
  --cloud | -c) source <(curl -s raw.wpi.pw/wpirock/master/bin/00-source.sh);;
  *)            source "${PWD}"/bin/00-source.sh;; # Load local source scripts
esac

bash bin/01-init.sh
bash bin/02-env.sh
bash bin/03-plugins.sh
bash bin/04-themes.sh
bash bin/05-settings.sh
