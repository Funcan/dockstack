FROM {{BASEIMAGE}}
MAINTAINER duncan.thomas@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#FIXME This shouldn't be necessary, we just did an update in the base image
RUN apt-get update

RUN apt-get install -y debconf-utils
#FIXME Should do something better with these passwords :-)
RUN echo "mysql-server-5.5 mysql-server/root_password_again password Som3Passw0rd" | debconf-set-selections
RUN echo "mysql-server-5.5 mysql-server/root_password password Som3Passw0rd" | debconf-set-selections
RUN apt-get install -y mysql-server
RUN mkdir /etc/service/mysql
ADD mysql-service-file /etc/service/mysql/run
RUN chmod 755 /etc/service/mysql/run

RUN sed -i 's/^bind-address.*=.*$/bind-address = ::/' /etc/mysql/my.cnf

ADD configure_msqld /root/configure_msqld
RUN chmod 755 /root/configure_msqld
RUN /root/configure_msqld
run rm /root/configure_msqld
