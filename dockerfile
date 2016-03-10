FROM ubuntu:trusty
MAINTAINER Oleksiy Zelikov <oleksiy.zelikov@student.uni-halle.de>

#Basierend auf DockerFile von nginx https://hub.docker.com/_/nginx/


ENV NGINX_VERSION 1.8.1-1~trusty

#Installation von nginx und php-Packages
#Aufraumen

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get install -y ca-certificates nginx=${NGINX_VERSION} gettext-base && \
	BUILD_PACKAGES="supervisor nginx php5-fpm git php5-mysql php-apc php5-curl php5-gd php5-intl php5-mcrypt php5-memcache php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-pgsql php5-mongo php5-ldap pwgen" && \
	apt-get -y install $BUILD_PACKAGES && \
	apt-get autoremove -y && \
	apt-get clean && \
	apt-get autoclean && \
	rm -rf /var/lib/apt/lists/* &&

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]


