FROM enclaive/gramine-os:latest

RUN apt-get update -y \
    && apt-get install -y redis-server libatomic1 \
    && rm -rf /var/lib/apt/lists/*

COPY conf/redis.conf /etc/redis/

WORKDIR /manifest

COPY redis-server.manifest.template .
RUN mkdir -m0777 /data \
    && gramine-argv-serializer "redis-server" "/etc/redis/redis.conf" > trusted_argv \
    && ./manifest.sh redis-server

# tcp/redis
EXPOSE 6379

ENTRYPOINT [ "/entrypoint/enclaive.sh" ]
CMD [ "redis-server", "/etc/redis/redis.conf" ]
