FROM romeoz/docker-apache-php:7.2

RUN apt update \
    && apt-get install -y curl git vim unzip libxslt-dev libbz2-dev libicu-dev postgresql postgresql-contrib libmemcached-dev php7.2-dev php7.2-mongo php-xdebug php7.2-bcmath php7.2-redis \
    && rm -rf /var/lib/apt/lists/*

RUN pecl install mongodb xdebug
RUN echo "extension=mongodb.so" >> /etc/php/7.2/apache2/php.ini;
RUN composer global require --prefer-dist phpunit/phpunit phpmd/phpmd pdepend/pdepend sebastian/phpcpd squizlabs/php_codesniffer theseer/phpdox phploc/phploc phing/phing mayflower/php-codebrowser codeception/codeception robmorgan/phinx

RUN ln -s ~/.composer/vendor/bin/pdepend /usr/local/bin/ \
	&& ln -s ~/.composer/vendor/bin/phpcbf /usr/local/bin/ \
	&& ln -s ~/.composer/vendor/bin/phpcpd /usr/local/bin/ \
	&& ln -s ~/.composer/vendor/bin/phpcs /usr/local/bin/ \
	&& ln -s ~/.composer/vendor/bin/phpdox /usr/local/bin/ \
	&& ln -s ~/.composer/vendor/bin/phploc /usr/local/bin/ \
	&& ln -s ~/.composer/vendor/bin/phpmd /usr/local/bin/ \
	&& ln -s ~/.composer/vendor/bin/phpunit /usr/local/bin/ \
	&& ln -s ~/.composer/vendor/bin/phing /usr/local/bin/ \
	&& ln -s ~/.composer/vendor/bin/phpcb /usr/local/bin/ \
	&& ln -s ~/.composer/vendor/bin/codecept /usr/local/bin/ \
    && ln -s ~/.composer/vendor/bin/phinx /usr/local/bin/

WORKDIR /var/www/html/

EXPOSE 80 443

CMD ["/sbin/entrypoint.sh"]
