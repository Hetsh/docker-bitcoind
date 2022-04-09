FROM amd64/alpine:20220328
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
        btcd=0.22.0_beta-r1

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
ARG BASE_DIR="/btcd"
RUN mkdir "$BASE_DIR" && \
    chown "$APP_USER":"$APP_USER" "$BASE_DIR"
VOLUME ["$BASE_DIR"]

USER "$APP_USER"
WORKDIR "$BASE_DIR"
ENV BASE_DIR="$BASE_DIR"
ENTRYPOINT exec btcd --configfile="$BASE_DIR/btcd.conf" --datadir="$BASE_DIR/data"
