# My PHP base container: https://github.com/karelbemelmans/docker-php-base
FROM karelbemelmans/php-base:7.1
MAINTAINER mail@karelbemelmans.com

# You should override this when you run the container!
# It will get appended to the New Relic appname in the entrypoint scripts e.g. my-php-container-local
ENV environment local

# Install New Relic
RUN set -x && DEBIAN_FRONTEND=noninteractive \
  && wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - \
  && echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list \
  && apt-get update \
  && apt-get install -y newrelic-php5 \
  && newrelic-install install \
  && rm -rf /var/lib/apt/lists/*

# We need to copy the New Relic config AFTER we installed the PHP extension
# or we get warnings everywhere about the missing PHP extension.
COPY config/newrelic.ini /usr/local/etc/php/conf.d/newrelic.ini

# Generate an example PHP file in the webroot
RUN echo '<?php phpinfo();' > /var/www/html/index.php

# Our entrypoint script that also modifies the New Relic config file
COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
