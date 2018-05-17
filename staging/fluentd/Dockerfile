FROM fluent/fluentd:v1.1-onbuild

MAINTAINER J. Scott Smith <scott@newleafsolutionsinc.com>

USER root

RUN apk add --update --virtual .build-deps sudo build-base ruby-dev \
  && sudo gem install fluent-plugin-mongo \
  && sudo gem install fluent-plugin-slack \
  && sudo gem sources --clear-all \
  && apk del .build-deps \
  && rm -rf /var/cache/apk/* /home/fluent/.gem/ruby/2.3.0/cache/*.gem

RUN addgroup -g 2000 -S fluent \
  && adduser -h /home/fluent -g '' -G fluent -S -D -u 2000 fluent
RUN chown -R fluent:fluent /home/fluent \
  && chown -R fluent:fluent /fluentd

USER fluent

ENTRYPOINT ["fluentd"]
CMD ["-c", "/fluentd/etc/fluent.conf", "-p", "/fluentd/plugins"]
