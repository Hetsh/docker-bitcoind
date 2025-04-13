FROM amd64/alpine:20250108
RUN apk update && \
    apk add --no-cache \
        bitcoin=27.0-r3 && \
    rm /etc/bitcoin.conf

# App user
ARG APP_USER="bitcoind"
ARG APP_UID=1380
RUN adduser \
    --disabled-password \
    --uid "$APP_UID" \
    --no-create-home \
    --gecos "$APP_USER" \
    --shell /sbin/nologin \
    "$APP_USER"

# Volumes
ARG DATA_DIR="/bitcoind"
RUN mkdir "$DATA_DIR" && \
    chown "$APP_USER":"$APP_USER" "$DATA_DIR"
VOLUME ["$DATA_DIR"]

USER "$APP_USER"
ENV DATA_DIR="$DATA_DIR"
ENTRYPOINT exec bitcoind --datadir="$DATA_DIR"
