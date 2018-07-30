FROM dendra/dendra-worker:preview

MAINTAINER J. Scott Smith <scott@newleafsolutionsinc.com>

USER root

RUN mkdir -p /data/state \
  && chown -R node:node /data/state
VOLUME /data/state

# Install tasks
RUN npm install @dendra-science/worker-tasks-agg

COPY production.json /home/node/app/config

# Best practice: run as user 'node'
USER node
