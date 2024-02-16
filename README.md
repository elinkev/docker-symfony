## Requirements & what this is
Current requirements are docker and git. This is a skeleton repository ment to quickly setup a working environment with this stack:

    Backend - Symfony (API), phpcs, phpstan, phpunit, mailhog
    Frotend - React, vite
    DB - MariaDB

    Symfony - http://localhost
    React - http://localhost:5173/
    Adminer - http://localhost:8080/
    Mailhog - http://localhost:8025/
    
## Project structure

```
.
├─ project
│  ├─ backend
│  │  ├─ app (symfony)
│  │  ├─ config
│  │  │  ├─ php-cs-fixer.dist
│  │  │  └─ php.ini
│  │  ├─ Dockerfile
│  │  └─ tools
│  │     ├─ entrypoint.sh
│  │     └─ php-cs-fixer.sh
│  └─ frontend
│     ├─ app (react + vite)
│     ├─ config
│     │  ├─ .eslintrc.json.dist
│     │  ├─ .prettierrc.dist
│     │  └─ tailwind.config.js.dist
│     ├─ .dockerignore
│     ├─ Dockerfile
│     └─ tools
│        └─ entrypoint.sh
├─ tools
│  └─ pre-commit.dist
├─ docker-compose.yml
└─ README.md

```

## Installation
- Start by cloning this repository - git clone git@github.com:elinkev/docker-symfony.git project_name
- Create an .env file and configure it `cp .env.dist .env`
- Buld the container `docker-compose up`
- Symfony DB connection string example in .env file - DATABASE_URL="mysql://db_user:db_password@db:3306/db_name?serverVersion=10.5.8-MariaDB", change db_user, db_password and db_name to values from docker-compose.yml values, verify that connection works by executing `symfony console doctrine:query:sql "show tables";`
- Setup pre-commit hook for phpcs + phpstan if needed `cp ./tools/pre-commit.dist .git/hooks/pre-commit` 


## Troubleshooting
Xdebug:
- Getting xdebug/opcache notifications when executing any cli commands - zend_extension= in .ini files is being duplicated somewhere
- Xdebug showing errors when executing commands in cli - set xdebug.start_with_request=trigger and then use either a browser extension as a trigger, or by exporting export XDEBUG_SESSION=yourname on the cli
- VSCode not reacting to xdebug - create launch.json config with correct pathMappings values, check APACHE_DOCUMENT_ROOT in Dockerfile and volumes in docker-compose up, example of working config:

    `ENV APACHE_DOCUMENT_ROOT=/var/www/html/public`
    `./project/backend/app:/var/www/html`

        "configurations": [
            {
                "name": "Listen for Xdebug",
                "type": "php",
                "request": "launch",
                "port": 9003,
                "pathMappings": {
                    "/var/www/html": "${workspaceFolder}/project/backend/app"
                }
            }
        ]    

VSCode:
- PHP executable errors - you probably dont have php installed locally, so point it to the docker container "php.validate.executablePath": "docker exec -t project_name-php php"
- To run phpcs on single file after save, runonsave extension is needed with this config for windows (adjust for linux), make sure its a workspace setting or you will have to change the project_name constantly:
    
        "emeraldwalk.runonsave": {
            "commands": [
                {
                    "match": "\\.php$",
                    "cmd": "docker exec -t project_name-php ./tools/windows/php-cs-fixer.sh ${relativeFile}"
                }
            ]
        },

- Pre commit hook not working in vsc - change pre-commit hook PHPCS="./tools/php-cs-fixer/vendor/bin/php-cs-fixer" to PHPCS="docker exec -t project_name-php ./tools/php-cs-fixer/vendor/bin/php-cs-fixer"

Mailhog:
- After installing symfony/mailer, .env parameter should look like this - MAILER_DSN=smtp://mailhog:1025

Tailwind:
- Remove all css from main .css file (index.css), and put:
```
    @tailwind base;
    @tailwind components;
    @tailwind utilities;
```

Vite:
- Add this config to vite.config.ts to instantly see changes when saving files
```
server: {
    watch: {
      usePolling: true,
  },
}
```

