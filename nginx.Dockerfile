FROM nginx:apline

COPY public /web/public
VOLUME ["/var/log/nginx"]