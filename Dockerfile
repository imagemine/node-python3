ARG VERSION=16-bullseye-slim
FROM node:${VERSION}

RUN apt-get update && \
    apt-get install -y libsqlite3-dev python3 cmake g++ && \
    rm -rf /var/lib/apt/lists/* && \
    yarn config set python /usr/bin/python3



