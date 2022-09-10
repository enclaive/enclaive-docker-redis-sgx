#! /bin/bash

if [ ! -f redis.crt ]
then
    echo "'redis.crt' does not exist. Generating a self-signed server cert"
    echo "Do NOT use self-signed certificates in production environments."
    openssl genrsa -out ca.key 2048
    openssl req -x509 -new -nodes -sha256 -key ca.key -days 3650 -subj '/O=Redis Test/CN=Certificate Authority' -out ca.crt
    openssl genrsa -out redis.key 2048
    openssl req -new -sha256 -key redis.key -subj '/O=Redis Test/CN=Server' -out redis.csr
    openssl x509 -req -sha256 -in redis.csr -CA ca.crt -CAkey ca.key -CAserial ca.txt -CAcreateserial -days 3650 -out redis.crt
else
    echo "'redis.crt' found. Parsing the certificate..."
fi

