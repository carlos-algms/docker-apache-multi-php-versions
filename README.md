# docker-apache-multi-php-versions
A docker image running Apache with multiple PHP versions

This is not a production ready image, it was created to replicate the usual PHP Shared Hosting environment

#### What is Included? 
* Apache2
* PHP 8, 7.4, and 7.1
* XDebug

## How to use
Apache will serve everything under `/home/abc/public_html`

Just mount a volume under that folder and, remap the PORTS as you wish:

#### docker-compose

```yaml
version: '3.9'

services:
  site:
    container_name: site
    image: carlosalgms/docker-apache-multi-php-versions:jammy
    ports:
      - 8080:8080
    volumes:
      - ./build/public:/home/abc/public_html
      - ./config:/home/abc/config
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
```

## Environment Variables

- `PUID` and `PGID` will be used to control the user `abc`, Apache and PHP will run under this user.
- `TZ` controls the timezone, defaults to `Europe/Berlin` 


## Customize

```
/home/abc/
|-- config/
|     |-- init.d/
|     |     `-- *.sh
|     |-- sites-enabled/
|     |     `-- *.conf
|     `-- ssl/
|-- logs/
|     |-- apache/
|     `-- php/
|-- public_html/
`-- tmp/
```
