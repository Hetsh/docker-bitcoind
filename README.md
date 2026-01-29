# Bitcoind
Small and easy to set up Bitocin Core Daemon.

## Running the server
```bash
docker run --detach --name bitcoind hetsh/bitcoind
```

## Stopping the container
```bash
docker stop bitcoind
```

## Creating persistent storage
Create persistent storage on your host to avoid data loss:
```bash
MP="/path/to/storage"
mkdir -p "$MP"
chown -R 1380:1380 "$MP"
```
`1380` is the numerical id of the user running the server (see Dockerfile).
The user must have RW access to the storage directory.
Start the server with the additional mount flag:
```bash
docker run --mount type=bind,source=/path/to/storage,target=/bitcoind ...
```

## Configuration
The node can be configured via config file (see [bitcoin-conf.md](https://github.com/bitcoin/bitcoin/blob/master/doc/bitcoin-conf.md))
Just place the `settings.json` into the storage directory and you are good to go.
