FROM node:21-alpine

# Set working directory
WORKDIR /app

# Copy files from docker root dir into container, then process them in the entrypoint script
COPY ./config/.eslintrc.json.dist /tmp/.eslintrc.json
COPY ./config/.prettierrc.dist /tmp/.prettierrc
COPY ./config/tailwind.config.js.dist /tmp/tailwind.config.js

COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "npm", "run", "dev", "--", "--port", "5173", "--host"]