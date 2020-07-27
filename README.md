# Docker

Slides [Docker and containers for Data Science](https://docs.google.com/presentation/d/1CeyQzwyLR9j-0bLmonuOgYLwQ4ky7UhLsmz8w_XaGwM/edit?usp=sharing) or in [PDF](Docker%20and%20containers%20for%20Data%20Science.pdf).

To follow this tutorial you need to have the Docker Engine installed. You can download it and install it from [here](https://docs.docker.com/engine/install/).

## Docker `images`

Docker images can be found in [Docker Hub](https://hub.docker.com).

Many packages and libraries offer a Docker version for users to test and deploy them wherever they want. Github repositories often include a Dockerfile with a neat installation of the repository.

## Dockerfiles

A `Dockerfile` contains the definition of a docker `image`. An image is like a template that defines what should go in a container.

```sh
docker pull postgres:10.4
docker pull mysql:8.0
docker pull python:3.7
```

This will download the images locally. To know more about Dockerfiles you can check out the [best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).

### Building your own docker images

A `Dockerfile` creates images with the following content.

```docker
FROM python:3.7

RUN apt-get update && apt-get install -y vim && pip install psycopg2 beautifulsoup4 lxml
```

The image will be based on the python:3.7 image and then it will install vim in the container and then the `psycopg2`, `beautifulsoup4`, `lxml` python packages.

To create the image from the Dockerfile run the following command.

```
docker build -t sds/python3_demo:1.0 .
```

### Listing images 
To list the images in the host machine.
```
docker images
```

To remove an image you simply run docker rmi with the image id of the image you want to remove.

```sh
docker rmi <IMAGE_ID>
```

### Running containers

Docker has many options to run containers.

```
$ docker run hello-world

# MySQL example
$ docker run --name sds-mysql-demo \
    -p 6603:3306 \
    --rm \
    -e MYSQL_USER=demo \
    -e MYSQL_PASSWORD=demo \
    -e MYSQL_ROOT_PASSWORD=rootpassword \
    -e MYSQL_DATABASE=sds_demo \
    -d \
    mysql:8.0

# Postgres example
$ docker run --name sds-postgres-demo \
    -p 6604:5432 \
    --rm \
    -e POSTGRES_PASSWORD=demo \
    -e POSTGRES_USER=demo \
    -e POSTGRES_DB=sds_demo \
    -d \
    postgres:10.4
```

To list the containers running in the host machine.

```
# To list the active containers (running)
docker ps
# To list all the containers in the system.
docker ps -a
# To list all the containers in the system with the size of them.
docker ps -as
```

To `stop`, `start` or `restart` containers you can use them as commands.
```
docker start sds-mysql-demo
docker stop sds-mysql-demo
docker restart sds-mysql-demo
```

To check container details such as IP or volumes we use `inspect`.

```
docker inspect sds-mysql-demo
```

To remote a container, the container has to be stopped.

```
docker rm sds-mysql-demo
# or the following if the container is running
docker rm $(docker stop sds-mysql-demo)
```

### Data volumes

For persistent storage one can use [volumes](https://docs.docker.com/storage/).

```
docker run \
    --name sds-demo \
    -h sds-demo \
    -it \
    -v "$(pwd)"/data:/tmp \
    -d \
    sds/python3_demo:1.0
```

To access into a container.

```
docker exec -it sds-demo bash
```

Copy data from and to a container.
```
docker cp <LOCAL_FILE> <CONTAINER_NAME>:/<PATH/IN/CONTAINER>
docker cp <CONTAINER_NAME>:/<PATH/IN/CONTAINER> .
```

## Jupyter notebooks

The following is an example to run jupyter lab in a container and store the files locally.

```
docker run \
    --rm \
    -p 10000:8888 \
    -e JUPYTER_ENABLE_LAB=yes \
    -v "$PWD":/home/jovyan/work \
    jupyter/datascience-notebook:9b06df75e445
```

More information about Jupyter in docker [here](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html)