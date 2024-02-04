## Requirements & what this is
Current requirements are docker and git. This is a skeleton repository ment to quickly setup a working environment with this stack:
    Backend - Symfony (API), phpcs, phpstan, phpunit, mailhog
    Frotend - React
    DB - MariaDB

    Adminer - http://localhost:8080/
    Mailhog - http://localhost:8025/
## Project structure
.
├── app
│   ├── backend
|   |   ├── tools
|   |   |    ├── php-cs-fixer
|   |   |    └── php-cs-fixer.sh
|   |   └── .php-cs-fixer.dist.php
│   └── frontend
├── docker
│   └── php
|       ├── config
|       |   └── php.ini 
|       ├── tools
|       |   └── php-cs-fixer.dist
|       ├── entrypoint.sh 
│       └── Dockerfile
├── tools
|   └── pre-commit.dist
├──.env.dist
├──.gitignore
├── docker-compose.yaml
└── README.md

## Installation
- Start by cloning this repository - git clone git@github.com:elinkev/docker-symfony.git project_name
- Create an .env file and configure it `cp .env.dist .env`
- Buld the container `docker-compose up`
- Symfony DB connection string example in .env file - DATABASE_URL="mysql://db_user:db_password@db:3306/db_name?serverVersion=10.5.8-MariaDB", change db_user, db_password and db_name to values from docker-compose.yml values, verify that connection works by executing `symfony console doctrine:query:sql "show tables";`
- Setup pre-commit hook for phpcs + phpstan if needed `cp ./tools/pre-commit.dist .git/hooks/pre-commit` 


<<<<<<< HEAD
## Troubleshooting
Xdebug:
    - Getting xdebug/opcache notifications when executing any cli commands - zend_extension= in .ini files is being duplicated somewhere
    - Xdebug showing errors when executing commands in cli - set xdebug.start_with_request=trigger and then use either a browser extension as a trigger, or by exporting export XDEBUG_SESSION=yourname on the cli
    - VSCode not reacting to xdebug - create launch.json config with correct pathMappings values, check APACHE_DOCUMENT_ROOT in Dockerfile and volumes in docker-compose up, example of working config:
        `ENV APACHE_DOCUMENT_ROOT=/var/www/html/public`
        `./app/backend:/var/www/html`

        ```bash
        "configurations": [
            {
                "name": "Listen for Xdebug",
                "type": "php",
                "request": "launch",
                "port": 9003,
                "pathMappings": {
                    "/var/www/html": "${workspaceFolder}/app/backend"
                }
            }
        ]    
        ```
VSCode:
    - PHP executable errors - you probably dont have php installed locally, so point it to the docker container "php.validate.executablePath": "docker exec -t project_name-php php"
    - To run phpcs on single file after save, runonsave extension is needed with this config for windows (adjust for linux), make sure its a workspace setting or you will have to change the project_name constantly:
        ```bash
            "emeraldwalk.runonsave": {
                "commands": [
                    {
                        "match": "\\.php$",
                        "cmd": "docker exec -t project_name-php ./tools/windows/php-cs-fixer.sh ${relativeFile}"
                    }
                ]
            },
        ```
    - Pre commit hook not working in vsc - change pre-commit hook PHPCS="./tools/php-cs-fixer/vendor/bin/php-cs-fixer" to PHPCS="docker exec -t project_name-php ./tools/php-cs-fixer/vendor/bin/php-cs-fixer"
Mailhog:
    - After installing symfony/mailer, .env parameter should look like this - MAILER_DSN=smtp://mailhog:1025
=======
- Create an `.env` file and configure it `cp .env.dist .env` 

- Build the docker image and launch the containers:
```bash
    docker build --pull --rm -f "Docker\Dockerfile" -t project_name:latest "Docker"
    docker-compose up
```

- Start a bash shell `docker exec -it project_name-php bash` 
- Check symfony requirements `symfony check:requirements` and start a new symfony project `symfony new . --version="7.0.*"`
    - `composer require symfony/apache-pack` install apache pack so that routes would work
- Create a new repository in github for your project https://github.com/new 
- Remove the initial cloned git details `rm -rf .git` and initialize new empty git repo `git init` then add the newly created repository, commit and push
```bash
    git remote add origin git@github.com:elinkev/test_repo_1.git
    git branch -M master
    git push -u origin master
```
## Troubleshooting
- Getting xdebug/opcache notifications when executing `php -v` or other commands - this is because zend_extension= config is being duplicated by something
- Xdebug showing errors when executing commands in cli - set `xdebug.start_with_request=trigger` and then use either a browser extension as a trigger, or by exporting export XDEBUG_SESSION=yourname on the command line
- VSCode not reacting to xdebug - create launch.json config with correct `pathMappings`:
```bash
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/var/www/html": "${workspaceFolder}/app"
            }
        }
    ]
```
- PHP executable errors - `"php.validate.executablePath": "docker exec -t project_name-php php"` 
- To run phpcs on single file after save, `runonsave` extension is needed with this config for windows (adjust for linux):
```bash
    "emeraldwalk.runonsave": {
        "commands": [
            {
                "match": "\\.php$",
                "cmd": "docker exec -t project_name-php ./tools/windows/php-cs-fixer.sh ${relativeFile}"
            }
        ]
    },
```
- Pre commit hook not working in vsc - change `PHPCS="./tools/php-cs-fixer/vendor/bin/php-cs-fixer"` to `PHPCS="docker exec -t project_name-php ./tools/php-cs-fixer/vendor/bin/php-cs-fixer"`

## Future plans
- Add VSC devcontainer configs
- How to setup and deploy project to prod (platform.sh or other)
- PHPStan, PHPCS, GitHook setup
>>>>>>> 856f1c3d123b8214f046d2da64b037dab750b27e
