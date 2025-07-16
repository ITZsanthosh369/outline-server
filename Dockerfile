FROM node:18-buster-slim


ARG VERSION

LABEL shadowbox.node_version=16.18.0
LABEL shadowbox.github.release=${VERSION}

STOPSIGNAL SIGKILL

# Use archive mirrors because Buster is EOL
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    apt-get update && apt-get install -y coreutils curl

COPY . /

WORKDIR /opt/outline-server

RUN npm install
RUN npm run build

CMD ["node", "dist/src/shadowbox/server/main.js"]
