#!/bin/sh

# PHP Coding Standards Fixer
PHPCSPATH=./tools/php-cs-fixer
if [ ! -d "$PHPCSPATH" ]; then
    echo "Installing PHP Coding Standards Fixer"
    mkdir -p "$PHPCSPATH"
    composer require --working-dir="$PHPCSPATH" friendsofphp/php-cs-fixer --no-interaction
fi

# Pre commit hook
PRECOMMITHOOKPATH=./tools/pre-commit
if [ ! -e ".git/hooks/pre-commit" ]; then
    echo "Copying pre-commit hook into .git dir"
    cp "$PRECOMMITHOOKPATH" .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
fi

exec "$@"
