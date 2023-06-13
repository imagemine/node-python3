FROM alpine:3.18.0

RUN apk update && \
    apk add sqlite-dev python3 cmake g++ nodejs npm yarn && \
    apk upgrade libcrypto3 libssl3 && \
    rm -rf /var/lib/apt/lists/* && \
    yarn config set python /usr/bin/python3 && \
    npm install -g sqlite3 && \
    yarn global add sqlite3


RUN addgroup -g 1000 -S appg && \
    addgroup -g 10000 -S app && \
    adduser -u 1000 -G app -S app && \
    adduser -u 10000 -G app -S user && \
    # For backward compatibility
    adduser app appg && \
    chown -R user:app /opt/app /libs /opt/db-migrations /flyway && \
    chmod -R g+rwx /opt/app /libs /opt/db-migrations /flyway

USER user

