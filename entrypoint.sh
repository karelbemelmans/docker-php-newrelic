#!/bin/bash -e

# Update the New Relic config for this environment
echo "newrelic.appname=my-php-container-${environment}" >> /usr/local/etc/php/conf.d/newrelic.ini

# Proceed with normal container startup
exec apache2-foreground

