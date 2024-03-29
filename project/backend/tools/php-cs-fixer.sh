#!/bin/bash

# This script replaces backslashes with forward slashes before for given path, also removes app/backend/
# app\backend\src\Controller\TestController.php -> src/Controller/TestController.php
# The idea here is VSCode ide saves a file, and executes phpcs script within backend docker and passes the path of the saved file

if [ -z "$1" ]; then
  echo "Usage: $0 <FilePath>"
  exit 1
fi

originalPath="$1"
linuxPath=$(echo $originalPath | tr '\\' '/')
linuxPath=$(echo "$linuxPath" | sed 's|project/backend/app/||')

./tools/php-cs-fixer/vendor/bin/php-cs-fixer fix $linuxPath