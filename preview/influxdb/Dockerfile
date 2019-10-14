FROM influxdb:1.7

MAINTAINER J. Scott Smith <scott@newleafsolutionsinc.com>

RUN groupadd --gid 2000 influx \
  && useradd --uid 2000 --gid 2000 influx

USER root

RUN mkdir -p /influxdb \
  && chown -R influx:influx /influxdb
VOLUME /influxdb

USER influx
