FROM influxdb:1.5.1

MAINTAINER J. Scott Smith <scott@newleafsolutionsinc.com>

RUN groupadd --gid 2000 influx \
  && useradd --uid 2000 --gid 2000 influx

USER root

RUN mkdir -p /influxdb \
  && chown -R influx:influx /influxdb
VOLUME /influxdb

USER influx
