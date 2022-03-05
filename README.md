Indexhibit Docker Image


Need to add phpenv library https://www.shiphp.com/blog/env-php-docker 
to make the install.php take default values from the environment variables
does not work at the mo

I need to clean up the Dockerfile and the entrypoint.sh

docker run -rm --name indexhibit indexhibit && docker exec -it indexhibit bash

-> docker run -it -p 8100:80 --env-file .env --rm indexhibit bash
-> docker run -p 8100:80 --env-file .env --rm indexhibit

build new image
-> docker build . -t indexhibit:latest

get server and database up 
-> docker-compose up