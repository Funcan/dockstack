FROM {{BASEIMAGE}}

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#FIXME This shouldn't be necessary, we just did an update in the base image
RUN apt-get update


RUN apt-get install -y rabbitmq-server
RUN mkdir /etc/service/rabbitmq
ADD rabbit-service-file /etc/service/rabbitmq/run
RUN chmod 755 /etc/service/rabbitmq/run
