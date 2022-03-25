# enclaive-docker-redis-sgx

SGX-ready Enclaive Docker Image for Redis

# info

The container currently does not store the database file outside the container.

Redis listens on `0.0.0.0` and is forwarded by docker, proper networking in `docker-compose.yml` or additional security measures are required.

The recommended settings from https://github.com/gramineproject/gramine/tree/master/CI-Examples/redis are not applied yet, since there was no error to be found while testing.
