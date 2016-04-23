FROM {{BASEIMAGE}}
MAINTAINER duncan.thomas@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ARG getref=master

#FIXME This shouldn't be necessary, we just did an update in the base image
RUN apt-get update

RUN apt-get install -y git python-pip python-virtualenv 

ADD build_cinder_venv /root/build_cinder_venv
RUN chmod 755 /root/build_cinder_venv
RUN /root/build_cinder_venv $getref

RUN mkdir /etc/cinder
