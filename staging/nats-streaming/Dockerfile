FROM nats-streaming:latest
FROM debian:stretch

MAINTAINER J. Scott Smith <scott@newleafsolutionsinc.com>

COPY --from=0 /nats-streaming-server /nats-streaming-server

RUN groupadd --gid 2000 stan \
  && useradd --uid 2000 --gid 2000 stan
RUN mkdir -p /datastore \
  && chown -R stan:stan /datastore
VOLUME /datastore

USER stan

ENTRYPOINT ["/nats-streaming-server"]
CMD ["-m", "8222", "--store", "FILE", "--dir", "datastore"]
