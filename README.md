# Laravel 11 Docker Starter
This is a starter project for Laravel 11 using Docker. It includes a web server (nginx with php-fpm), a database server (mysql), and a redis server. With small adjustments, it can be used for real production projects.

It uses [serversideup](https://serversideup.net/open-source/docker-php/docs) images for the web server, queue worker, and scheduler.

## Installation
1. Clone the repository: `git clone git@github.com:mattb-it/laravel11-docker-starter.git laravel_project`
2. Add execute permission to the `kickstarter.sh` file by running `chmod +x kickstarter.sh`
3. Run `./kickstarter.sh <project_name>`, replace `<project_name>` with the name of your project
4. Run `docker-compose up -d`
5. Enjoy! 🎉

## Cleanup (Optional, read carefully)
You can remove example docker file and kickstarter script by running `./kickstarter_cleanup.sh` script. It simply removes following files:
- `docker-compose.local.yml.example`
- `kickstarter.sh`
- `kickstarter_cleanup.sh`
- `README.md`
- `.git`

It is useful if you want to use this project as a base for your own project.

## URLs
Once started, you can access Laravel 11 at:
- [http://localhost:8888](http://localhost:8888)
- [https://localhost:444](https://localhost:444)
