#!/bin/sh

PHPCSPATH=./tools/php-cs-fixer
if [ ! -d "$PHPCSPATH" ]; then
    echo "Installing PHP Coding Standards Fixer"
    mkdir -p "$PHPCSPATH"
    composer require --working-dir="$PHPCSPATH" friendsofphp/php-cs-fixer --no-interaction
fi

exec "$@"
