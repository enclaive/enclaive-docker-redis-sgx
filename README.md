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
docker exec -ti redis redis-cli --tls --cacert /tls/ca.crt set mysecret red
```


## Observe that it's possible to find the message content in memory

```sh
sudo gcore -o core.vanilla $(pgrep redis-server)
grep mysecret core.vanilla.*
grep: core.vanilla.25575: binary file matches
```

## Set a key on the encryped redis

```sh
docker exec -ti redis-sgx redis-cli --tls --cacert /tls/ca.crt set mysecret red
```

## Observe that it's NOT possible to find the message content in memory

```sh
sudo gcore -o core.sgx $(pgrep loader)
grep mysecret core.sgx.*
<nothing>
```
