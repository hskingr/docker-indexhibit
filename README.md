## Getting Started

There is a template `.env.example` file available in the repo. Rename the file to `.env` and add in your values for the docker-compose file to read. The recommended deployment option is to use the `docker-compose.yaml` file provided. If you have another mysql/mariadb server that you would like to use, make sure you change the environment values and remove the db portion in the docker-compose.

I would recommend the way of setting up the domain name pointers is by not exposing the ports of the docker container and run a reverse proxy in front of your server. Make sure the reverse proxy runs in a container on the same docker network as indexhibit and just expose the http/https ports from there. You should be able to route traffic via the hostnames of the containers and easily generate SSL certificates from the reverse proxy.

### Prerequisites

Firstly, build the image:

`docker-compose build`

Then do:

`docker-compose up -d`

Once the containers have started, go to your browser and follow the setup instructions for the CMS. Some of the environment variables have already been added to the input fields to minimise error and provide convienience. The address to finish the setup is:

`http://<yourAddress>/nxzstudio/install.php`

### docker-compose

```yaml
version: '3.7'
services:
  indexhibit:
    image: indexhibit:latest
    build:
      context: .
    container_name: indexhibit
    restart: unless-stopped
    volumes:
      - $DATA_DIR/html:/var/www/html:rw
      - $DATA_DIR/sites-available:/etc/apache2/sites-available:rw
    environment:
      - SITE_NAME
      - USER_NAME
      - USER_LAST_NAME
      - EMAIL
      - DATABASE_SERVER_ADDRESS
      - MARIADB_DATABASE
      - MARIADB_USER
      - MARIADB_PASSWORD
    ports:
    - 80:80
    - 443:443
  database:
    image: mariadb:10.3
    container_name: indexhibit-db
    restart: always
    environment:
      - MARIADB_USER
      - MARIADB_PASSWORD
      - MARIADB_DATABASE
      - MARIADB_ROOT_PASSWORD
    volumes:
      - ${DATA_DIR}/mysql:/var/lib/mysql
```
## Environment Variables

Some environment variables can be set to customize the behaviour of the container
and its application.  The following list give more details about them.

| Variable       | Description
|----------------|----------------------------------------------
|`SITE_NAME`| Name of the Indexhibit site.
|`USER_NAME`| Name for the Indexhibit account.
|`USER_LAST_NAME`| Last name for the Indexhibit account.
|`EMAIL`| Email for the Indexhibit account.
|`DATABASE_SERVER_ADDRESS`| The address of the database you are using. If you decide to use the docker-compose provided, then the address will be the container name of the database.
|`MARIADB_USER`| The username for the Indexhibit database account.
|`MARIADB_PASSWORD`| The password for the Indexhibit database account.
|`MARIADB_DATABASE`| The name of the database for Indexhibit to connect to.
|`MARIADB_ROOT_PASSWORD`| The root password for the database account.
|`DATA_DIR`| The directory where you want to persist the database and Indexhibit website files.

## Volumes & Parameters

Parameters are formatted as such: `internal`:`external`.

| Parameter | Function |
| :----: | --- |
| `-v <DATA_DIR>/html:/var/www/html:rw` | This directory gets populated when the container first starts. All the configurations, static and media files exist for the CMS here.|
| `-v <DATA_DIR>/sites-available:/etc/apache2/sites-available:rw` | This directory gets populated when the container first starts. Its purpose is to setup site configuration with apache. |


