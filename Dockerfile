# Copyright 2018 The Outline Authors
# Licensed under the Apache License, Version 2.0...

FROM node:16-buster-slim

ARG VERSION

LABEL shadowbox.node_version=16.18.0
LABEL shadowbox.github.release=${VERSION}

STOPSIGNAL SIGKILL

# FIXED: Use apt-get (not apk) for Debian-based image
RUN apt-get update && apt-get install -y coreutils curl

COPY . /

RUN /etc/periodic/weekly/update_mmdb.sh

WORKDIR /opt/outline-server

CMD ["/cmd.sh"]
