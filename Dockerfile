FROM hetsh/alpine:20260127-1
ARG LAST_UPGRADE="2026-02-15T15:53:33+01:00"
RUN apk upgrade --no-cache && \
	apk add --no-cache \
		bitcoin=30.2-r1 && \
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

# Data folder
ARG DATA_DIR="/bitcoind"
RUN mkdir "$DATA_DIR" && \
	chown "$APP_USER":"$APP_USER" "$DATA_DIR"

USER "$APP_USER"
ENTRYPOINT ["bitcoind", "--datadir=/bitcoind"]
