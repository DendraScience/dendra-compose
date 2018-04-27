FROM nginx

MAINTAINER J. Scott Smith <scott@newleafsolutionsinc.com>

COPY www /var/www
RUN chown -R nginx:nginx /var/www

COPY nginx.conf /etc/nginx/nginx.conf
