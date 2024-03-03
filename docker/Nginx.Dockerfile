FROM nginx:1.25.4-bookworm

RUN apt-get update  \
    && apt-get upgrade

ADD docker/conf/default.conf /etc/nginx/conf.d/default.conf
