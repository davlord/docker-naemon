# davlord/naemon
Dockerfile to build a [Naemon](http://www.naemon.org/) image for the [Docker](https://www.docker.com/products/docker-engine) opensource container platform.

# Quick Start
Startup a container
```bash
docker run --name naemon -d \
    --env 'EMAIL_SENDER=someone@somedomain.com' \
    --volume /your/host/path/naemon.d:/etc/naemon/conf.d \
    -p 80:80 \
    davlord/naemon
```
Environment variable `EMAIL_SENDER` is mandatory and should match an existing email address.

If mounted volume is an empty directory, default naemon configuration files will be created. 
Update configuration files to your needs and restart container.

Access user Web interface [http://yourhost/naemon/](http://yourhost/naemon/) with user `thrukadmin` and password `thrukadmin`

# Advanced Usage
## Environment Variables
- `EMAIL_SENDER`: Naemon email alerts sender address (mandatory)
- `NAEMON_WEB_USER`: Naemon web interface authentication user name
- `NAEMON_WEB_PASSWORD`: Naemon web interface authentication password

## Docker Compose Example
Example `docker-compose.yml` file:
```bash
naemon:
   image: davlord/naemon
   environment:
     - EMAIL_SENDER=someone@somedomain.com
     - NAEMON_WEB_USER=admin
     - NAEMON_WEB_PASSWORD=mypassword
   volumes:
     - ./naemond.d:/etc/naemon/conf.d
   ports:
     - "80:80"
```
