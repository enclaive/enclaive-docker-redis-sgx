# Redis-SGX Demonstration

The goal is to show that the in-memory database redis is secure even in presence of memory dumps. The rationality is that the enclaived redis constainer redis-sgx by design is memory encrypted and thus at any moment in time the dump consists of ciphertexts. We show this by searching for the string `mysecret` both in redis-sgx as well as in vanilla redis.

## Prerequisites
Install `gcore` to dumb the memory
```sh
sudo apt install gdb
```

## Building and Running

```sh
docker compose up
```

## Set a key on the unencryped redis

```sh
docker exec -ti redis redis-cli set mysecret red
```


## Observe that it's possible to find the message content in memory

```sh
ps aux | grep redis-server
sudo gcore 50866    # pid redis-server 0.0.0.0:6379
grep mysecret core.50866
grep: core.50866: binary file matches
```

## Set a key on the encryped redis

```sh
docker exec -ti redis-sgx redis-cli set mysecret red
```

## Observe that it's NOT possible to find the message content in memory

```sh
ps aux | grep enclaive
sudo gcore 26187    # pid /bin/bash /entrypoint/enclaive.sh redis-server /etc/redis/redis.conf
grep mysecret core.26187
<nothing>
```
