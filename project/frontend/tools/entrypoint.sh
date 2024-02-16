#!/bin/sh

# Installing frontend if /app (workdir) directory is empty
if [ -z "$(ls -A)" ]; then
    echo "Installing react"
    npm install create-vite -g &&
    npm create vite@latest . -- --template react-ts &&
    npm install
    echo "Installing dev packages"
    npm install --save-dev tailwindcss prettier-plugin-tailwindcss postcss autoprefixer prettier eslint eslint-config-prettier eslint-import-resolver-typescript @typescript-eslint/eslint-plugin @typescript-eslint/parser &&
    npx tailwindcss init -p &&
    mv /tmp/.eslintrc.json .eslintrc.json &&
    mv /tmp/.prettierrc .prettierrc &&
    mv /tmp/tailwind.config.js tailwind.config.js 
fi

exec "$@"