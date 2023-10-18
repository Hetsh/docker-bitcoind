# Work In Progress

# Bitcoind
Super small and easy to set up Bitocin Core Daemon.

## Running the server
```bash
docker run --detach --name bitcoind hetsh/bitcoind
```

## Stopping the container
```bash
docker stop bitcoind
```

## Creating persistent storage
```bash
MP="/path/to/storage"
mkdir -p "$MP"
chown -R 1380:1380 "$MP"
```
`1380` is the numerical id of the user running the server (see Dockerfile).
Start the server with the additional mount flag:
```bash
docker run --mount type=bind,source=/path/to/storage,target=/bitcoind ...
```

## Configuration
The node can be configured via config file (see [bitcoin-conf.md](https://github.com/bitcoin/bitcoin/blob/master/doc/bitcoin-conf.md))
Just place the `settings.json` into the storage directory and you are good to go.

## Automate startup and shutdown via systemd
The systemd unit can be found in my GitHub [repository](https://github.com/Hetsh/docker-bitcoind).
```bash
systemctl enable bitcoind.service --now
```
By default, the systemd service assumes `/apps/bitcoind` for persistent storage and `/etc/localtime` for timezone.
Since this is a personal systemd unit file, you might need to adjust some parameters to suit your setup.

## Fork Me!
This is an open project (visit [GitHub](https://github.com/Hetsh/docker-bitcoind)).
Please feel free to ask questions, file an issue or contribute to it.