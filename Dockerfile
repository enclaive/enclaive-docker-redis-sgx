FROM enclaive/gramine-os:latest

# set to noninteractive for debconf, just in case
ENV DEBIAN_FRONTEND noninteractive

# install required packages
RUN apt-get update -y && apt-get install -y \
    redis-server \
    libatomic1


# copy configuration
WORKDIR /etc/redis/
COPY conf/redis.conf .
RUN mkdir -m0777 /data


# create manifest and argument files
WORKDIR /manifest
COPY redis-server.manifest.template .
RUN gramine-argv-serializer "redis-server" "/etc/redis/redis.conf" > trusted_argv
RUN ./manifest.sh redis-server


# tcp/redis
EXPOSE 6379


ENTRYPOINT [ "/entrypoint/enclaive.sh" ]
CMD [ "redis-server", "/etc/redis/redis.conf" ]
