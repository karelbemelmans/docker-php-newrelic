# PHP Docker container with New Relic agent

A simple example PHP 7 Docker container with the New Relic agent installed.

## Installation instructions

First update the code:

  - Update config/newrelic.ini with your license id and more options if needed
  - Update entrypoint.sh with your New Relic appname


Then build and run the container:

```
docker build -t php-newrelic .
docker run -p "8080:80" -it php-newrelic
```

The container will be up and running at http://localhost:8080 and will display the PHP Info page.

## Remarks

The New Relice license id could be added as an ENV variable in the Dockerfile and then filled into the config in the entrypoint scripts.
