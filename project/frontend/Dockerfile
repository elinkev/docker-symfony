FROM node:21-alpine

# Set working directory
WORKDIR /app

COPY ./app/package*.json .

# npm install - installs from pacakge.json, npm ci - installs from package-lock.json
RUN npm ci

# COPY . /app
COPY . .

CMD [ "npm", "run", "dev" ]