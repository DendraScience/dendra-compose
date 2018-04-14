FROM mongo:3.4

MAINTAINER J. Scott Smith <scott@newleafsolutionsinc.com>

RUN groupmod -g 2000 mongodb \
  && usermod -u 2000 -g 2000 mongodb

COPY auth-entrypoint.sh /auth-entrypoint.sh
RUN chmod +x /auth-entrypoint.sh

COPY auth-init.sh /auth-init.sh
RUN chmod +x /auth-init.sh
