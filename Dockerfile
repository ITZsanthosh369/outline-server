FROM node:16-buster-slim

ARG VERSION

LABEL shadowbox.node_version=16.18.0
LABEL shadowbox.github.release=${VERSION}

STOPSIGNAL SIGKILL

# Use archive mirrors because Buster is EOL
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    apt-get update && apt-get install -y coreutils curl

COPY . /
RUN npm install
RUN npm run build

#RUN /etc/periodic/weekly/update_mmdb.sh

WORKDIR /opt/outline-server

CMD ["/cmd.sh"]
