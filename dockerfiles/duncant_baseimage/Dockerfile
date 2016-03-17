# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.18

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Lets update to the latest versions of anything installed
RUN apt-get -y update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# I want ssh enabled inside all my containers
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
ADD authorized_keys /tmp/authorized_keys
RUN cat /tmp/authorized_keys >> /root/.ssh/authorized_keys && rm -f /tmp/your_key.pub
RUN chmod 600 /root/.ssh/authorized_keys

# I don't need cron in my containers by default, thanks
RUN touch /etc/service/cron/down

# Clean up APT when we're done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


