FROM kapacitor:1.4.1

MAINTAINER J. Scott Smith <scott@newleafsolutionsinc.com>

RUN groupadd --gid 2000 influx \
  && useradd --uid 2000 --gid 2000 influx

USER root

RUN mkdir -p /kapacitor \
  && chown -R influx:influx /kapacitor
VOLUME /kapacitor

USER influx
