FROM enclaive/gramine-os:jammy-7e9d6925

RUN apt-get update -y \
    && apt-get install -y redis-server libatomic1 \
    && rm -rf /var/lib/apt/lists/*

COPY conf/redis.conf /etc/redis/

WORKDIR /manifest

COPY redis-server.manifest.template .

RUN gramine-argv-serializer "redis-server" "/etc/redis/redis.conf" > trusted_argv \
    && ./manifest.sh redis-server

VOLUME /data/ /logs/

EXPOSE 6379/tcp

ENTRYPOINT [ "/entrypoint/enclaive.sh", "redis-server" ]
