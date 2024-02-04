#!/bin/sh

# Installing symfony if /backend directory is empty
if [ -z "$(ls -A)" ]; then
    echo "Installing symfony"
    set -x
    # Install symfony with composer, cli initialized git which is not needed in this dir
    symfony composer create-project symfony/skeleton:"7.0.*" . &&
    symfony composer config extra.symfony.allow-contrib true &&
    symfony composer require symfony/apache-pack &&
    symfony composer require symfony/orm-pack &&
    symfony composer require symfony/maker-bundle --dev &&
    symfony composer require symfony/mailer &&
    symfony composer require phpstan/phpstan --dev &&
    symfony composer require phpunit/phpunit ^11 --dev &&
    set +x
fi

# Installing phpcs if /tools/php-cs-fixer dir doesnt exist
PHPCSPATH=./tools/php-cs-fixer
if [ ! -d "$PHPCSPATH" ]; then
    set -x
    echo "Installing PHP Coding Standards Fixer"
    mkdir -p "$PHPCSPATH" &&
    symfony composer require --working-dir="$PHPCSPATH" friendsofphp/php-cs-fixer --no-interaction &&
    mv /usr/local/bin/php-cs-fixer.sh ./tools &&
    mv /.php-cs-fixer.dist.php .
    set +x
fi

# # Pre commit hook
# PRECOMMITHOOKPATH=./tools/pre-commit
# if [ ! -e ".git/hooks/pre-commit" ]; then
#     echo "Copying pre-commit hook into .git dir"
#     cp "$PRECOMMITHOOKPATH" .git/hooks/pre-commit
#     chmod +x .git/hooks/pre-commit
# fi

exec "$@"