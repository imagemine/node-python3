ARG NODE_VERSION=18.16.0
FROM alpine:3.18.0

RUN apk update && \
    apk add sqlite-dev python3 cmake g++ nodejs npm yarn && \
    apk upgrade libcrypto3 libssl3 binutils && \
    rm -rf /var/lib/apt/lists/* && \
    yarn config set python /usr/bin/python3 && \
    npm install -g sqlite3 better-sqlite3 node-gyp && \
    yarn global add sqlite3 better-sqlite3 node-gyp


RUN addgroup -g 1000 -S appg && \
    addgroup -g 10000 -S app && \
    adduser -u 1000 -G app -S app && \
    adduser -u 10000 -G app -S user && \
    # For backward compatibility
    adduser app appg && \
    mkdir -p /opt/app && mkdir -p /opt/db-migrations && ln -s /opt/app /libs && ln -s /opt/db-migrations /flyway && \
    chown -R user:app /opt/app /libs /opt/db-migrations /flyway && \
    chmod -R g+rwx /opt/app /libs /opt/db-migrations /flyway

USER user

