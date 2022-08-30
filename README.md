SGX redis demonstration


## Building and Running

```sh
docker-compose up
```

## set a key on the unencryped redis

```sh
docker exec -ti redis redis-cli set mysecret geheim
```


## observe that it's possible to find the message content in memory

```sh
ps aux | grep redis-server
sudo gcore 50866
grep mysecret core.50866
grep: core.50866: binary file matches
```

## set a key on the encryped redis

```sh
docker exec -ti redis-sgx redis-cli set mysecret geheim
```

## observe that it's NOT possible to find the message content in memory

```sh
ps aux | grep gramine
sudo gcore 26187
grep mysecret core.26187
<nothing>
```
