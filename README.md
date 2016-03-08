## Run it

`docker run -it -d --name hello -p 8080:80 aerth/php:latest`

####################

Or you may want to customize and tag your own image.

## Build

`docker build -t username/php .`

## Serve

`docker run -it -d --name hello -p 8080:80 username/php:latest`

## Hack

`$ docker exec -it hello bash`
`bash-4.3# apk update && apk add nano vim`
`exit`

## Save Changes

`$ docker commit hello aerth/hello:latest`

## Launch your new thang

`$ docker run -it -d -p 8081:80 aerth/hello:latest`
