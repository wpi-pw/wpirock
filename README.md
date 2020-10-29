<p align="center">
  <a href="https://wpi.pw/wpirock/">
    <img alt="WpiRock" src="/logo-wpi.svg" height="100">
  </a>
</p>

<p align="center">
  <strong>A classic WordPress stack</strong>
  <br />
  Built with ❤ to WPI️
</p>

## Supporting

**WpiRock** is an open source project and completely free to use.

However, the amount of effort needed to maintain and develop new features and products within the WPI ecosystem is not sustainable without proper financial backing. If you have the capability, please consider donating using the links below:

<div align="center">

[![Donate via PayPal](https://img.shields.io/badge/donate-paypal-blue.svg?style=flat-square&logo=paypal)](https://www.paypal.me/cdkdev)

</div>

## Overview

WpiRock is a classic WordPress stack that helps you get started with the best development tools.

## Features

- Dependency management with [wp-cli](https://wp-cli.org)
- Easy WordPress configuration with environment specific configs
- Environment variables with [yaml](https://en.wikipedia.org/wiki/YAML)
- Autoloader for mu-plugins

## Requirements

- Ubuntu >= 18.04
- PHP >= 5.6
- MySQL
- wget and curl
- JQ - [Install](https://stedolan.github.io/jq/download/)
- WP CLI - [Install](https://make.wordpress.org/cli/handbook/guides/installing/)

## Installation

1. Create a new project:
   ```sh
   $ wget -qO wpirock.sh wpi.pw/bin/wpirock.sh && bash wpirock.sh
   ```
2. Update environment variables with WpiRock cli wizard
- Database variables
  - `DB_NAME` - Database name
  - `DB_USER` - Database user
  - `DB_PASSWORD` - Database password
  - `DB_HOST` - Database host
- `WP_ENVIRONMENT_TYPE` - Set to environment (`development`, `staging`, `production`, `custom_env`)
- `WP_HOME` - Full URL to WordPress home (https://example.com)
- `WP_SITEURL` - Full URL to WordPress including subdirectory (https://example.com)
- Custom variables
3. Add theme(s) via WpiRock wizard
4. Add plugin(s) via WpiRock wizard
5. Add must-use plugin(s) via WpiRock wizard
6. Set project public path to `~/current_path/app` in your server

## Documentation

WpiRock documentation is available at [wpi-pw/wpirock/wiki](https://github.com/wpi-pw/wpirock/wiki).

## Contributing

Contributions are welcome from everyone.

## WPI sponsors

Help support our open-source development efforts by [Donate via PayPal](https://www.paypal.me/cdkdev).
