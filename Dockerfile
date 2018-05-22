# Pull base image
FROM resin/armv7hf-debian:stretch
MAINTAINER Dominik Liebmann <dominik_l@gmx.net>

ARG LMS_VERSION=7.9.1
ARG LMS_DEB=logitechmediaserver_${LMS_VERSION}_all.deb

# Install dependencies
#RUN apt-get update && apt-get install -y \
#    openjdk-7-jre \
#    --no-install-recommends && \
#    rm -rf /var/lib/apt/lists/*


RUN apt-get update && sudo apt-get dist-upgrade && \
    apt-get install libexif12 flac patch wget libio-socket-ssl-perl libgomp1 perl && \
    wget -nv -O /tmp/$LMS_DEB http://downloads.slimdevices.com/LogitechMediaServer_v$LMS_VERSION/$LMS_DEB && \
    dpkg -i /tmp/$LMS_DEB && \
    touch /var/log/squeezeboxserver/perfmon.log && \
    touch /var/log/squeezeboxserver/server.log && \
    mkdir -p /var/lib/squeezeboxserver/prefs/plugin && \
    chown -R squeezeboxserver:nogroup /var/lib/squeezeboxserver/prefs/ && \
    chown -R squeezeboxserver:nogroup /var/log/squeezeboxserver/ && \
    chown -R squeezeboxserver:nogroup /usr/share/squeezeboxserver/ && \
    mkdir -p /var/music && \
    chown -R squeezeboxserver:nogroup /var/music && \
    ln -s /var/music /media/music && \
    apt-get clean autoclean autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    rm /tmp/$LMS_DEB && \
    rm -rf /var/lib/apt/lists/*

#RUN chown -R squeezeboxserver:nogroup /var/lib/squeezeboxserver/prefs/ && \
#    chown -R squeezeboxserver:nogroup /var/log/squeezeboxserver/ && \
#    chown -R squeezeboxserver:nogroup /usr/share/squeezeboxserver/

# Set timezone accordingly
RUN echo "Europe/Berlin" > /etc/timezone && export TZ=Europe/Berlin

# Define working directory
WORKDIR /data

EXPOSE 9000

COPY startup.sh /startup.sh

# Define default command
#CMD ["bash"]
CMD []
ENTRYPOINT ["/startup.sh"]

