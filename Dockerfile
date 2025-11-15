FROM amd64/alpine:20250108
ARG LAST_UPGRADE="2025-11-15T12:29:19+01:00"
RUN apk upgrade && \
    apk add --no-cache \
        bitcoin=27.0-r4 && \
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
