#davlord/naemon
Dockerfile to build a [Naemon](http://www.naemon.org/) image for the [Docker](https://www.docker.com/products/docker-engine) opensource container platform.

#Quick Start
Startup a container
```bash
docker run --name naemon -d \
    --env 'EMAIL_SENDER=someone@somedomain.com' \
    --volume /your/host/path/naemon.d:/etc/naemon/conf.d \
    davlord/naemon
```
If mounted volume is an empty directory, default naemon configuration files will be created. 
Update configuration files to your needs and restart container.

Environment variable `EMAIL_SENDER` is mandatory and should match an existing email address.
