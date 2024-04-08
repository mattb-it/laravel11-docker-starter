#!/bin/bash

# Usage: ./kickstarter.sh <project_name>

# Check if the user has provided an argument
if [ -z "$1" ]
  then
    echo "No argument supplied. Please provide the name of the app"
    exit 1
fi

# Copy the docker-compose.local.yml.example to docker-compose.local.yml
cp docker-compose.local.yml.example docker-compose.local.yml

# Replace the {appname} placeholder with the name from cli argument
sed -i '' "s/{appname}/$1/g" docker-compose.local.yml

# Copy the .env.example to .env
cp .env.example .env

# Now build the project
docker-compose -f docker-compose.local.yml build

# Configure application key by running php artisan key:generate on the {appname}_webserver container
path=$(pwd)
docker run -it -v $path:/var/www/html serversideup/php:beta-8.3-cli php artisan key:generate

echo "✅ Project $1 has been kickstarted successfully! Build something awesome! 🚀"
