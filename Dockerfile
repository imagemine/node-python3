FROM alpine:edge
ENV NODE_VERSION=20.12.2

RUN rm -rf /usr/lib/node_modules
RUN apk update
RUN apk add --no-cache --update sqlite-dev python3 cmake g++ nodejs yarn npm
RUN rm -rf /var/cache/apk/*
RUN apk upgrade --no-cache libcrypto3 libssl3 binutils libarchive
RUN rm -rf /var/lib/apt/lists/*
RUN yarn config set python /usr/bin/python3
RUN npm cache clean -f
RUN yarn cache clean -f
RUN npm install -g better-sqlite3 node-gyp
RUN yarn global add better-sqlite3 node-gyp


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
