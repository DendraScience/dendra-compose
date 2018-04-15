FROM debian:stretch

MAINTAINER J. Scott Smith <scott@newleafsolutionsinc.com>

COPY nats-streaming-server /usr/local/bin/nats-streaming-server

RUN groupadd --gid 2000 stan \
  && useradd --uid 2000 --gid 2000 stan
RUN mkdir -p /datastore \
  && chown -R stan:stan /datastore
VOLUME /datastore

USER stan

# Expose client and management ports
EXPOSE 4222 8222

# Run with file based store 
ENTRYPOINT ["nats-streaming-server"]
CMD ["-m", "8222", "--store", "FILE", "--dir", "datastore"]
