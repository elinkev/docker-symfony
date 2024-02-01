#!/bin/bash

# This script replaces backslashes with forward slashes before for given path
# app\src\Controller\ExampleController.php -> app/src/Controller/ExampleController.php
# The idea here is VSCode ide saves a file, and executes phpcs script from docker and passes the saved file

if [ -z "$1" ]; then
  echo "Usage: $0 <WindowsPath>"
  exit 1
fi

windowsPath="$1"
linuxPath=$(echo $windowsPath | tr '\\' '/')

./tools/php-cs-fixer/vendor/bin/php-cs-fixer fix $linuxPath
