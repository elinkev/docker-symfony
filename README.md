## Requirements
- Docker & git

## Installation

- Start by cloning this repository - `git clone git@github.com:elinkev/docker-symfony.git project_name`

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
## Future plans
- Add VSC devcontainer configs
- How to setup and deploy project to prod (platform.sh or other)
- PHPStan, PHPCS, GitHook setup
