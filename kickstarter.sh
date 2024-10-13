#!/bin/bash

# Usage: ./kickstarter.sh <project_name>

# Check if docker is up and running
if ! docker info > /dev/null 2>&1; then
    echo "Cannot connect to the Docker daemon. Is the docker daemon running?"
    exit 1
fi

# Check if the user has provided an argument
if [ -z "$1" ]
  then
    echo "No argument supplied. Please provide the name of the app"
    exit 1
fi

# Cleanup working directory by removing all files and directories except files: kickstarter.sh, kickstarter_cleanup.sh, docker-compose.local.yml.example and Dockerfile-cli.
find . -maxdepth 1 -type f -not -name 'kickstarter.sh' -not -name 'kickstarter_cleanup.sh' -not -name 'docker-compose.local.yml.example' -not -name 'Dockerfile-cli' -exec rm -rf {} \;
find . -maxdepth 1 -type d -not -name '.' -exec rm -rf {} \;

# Copy the docker-compose.local.yml.example to docker-compose.local.yml
cp docker-compose.local.yml.example docker-compose.local.yml

# Replace the {appname} placeholder with the name from cli argument
sed -i '' "s/{appname}/$1/g" docker-compose.local.yml

# Download Laravel
path=$(pwd)
docker run -it -v $path:/var/www/html serversideup/php:8.3-cli composer create-project laravel/laravel laravel

# Copy all files and folders (even hidden) from laravel to the root of the project and remove laravel folder
cp -a laravel/. .
rm -rf laravel

# Copy the .env.example to .env
cp .env.example .env

# Now build the project
docker-compose -f docker-compose.local.yml build

# Configure application key by running php artisan key:generate on the {appname}_webserver container
docker run -it -v $path:/var/www/html serversideup/php:8.3-cli php artisan key:generate

echo "✅ Project $1 has been kickstarted successfully! Build something awesome! 🚀"
