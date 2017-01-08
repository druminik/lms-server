# Pull base image
FROM resin/odroid-c1-debian:wheezy
MAINTAINER Dominik Liebmann <dominik_l@gmx.net>

# Install dependencies
#RUN apt-get update && apt-get install -y \
#    openjdk-7-jre \
#    --no-install-recommends && \
#    rm -rf /var/lib/apt/lists/*


RUN apt-get update && sudo apt-get dist-upgrade && \
    apt-get install libjpeg8 libpng12-0 libgif4 libexif12 libswscale2 libavcodec53 flac patch wget && \
    wget -nv -O /tmp/logitechmediaserver_7.8.0_all.deb http://downloads.slimdevices.com/LogitechMediaServer_v7.8.0/logitechmediaserver_7.8.0_all.deb && \
    dpkg -i /tmp/logitechmediaserver_7.8.0_all.deb && \
    touch /var/log/squeezeboxserver/perfmon.log && \
    touch /var/log/squeezeboxserver/server.log && \
    mkdir -p /var/lib/squeezeboxserver/prefs/plugin && \
    chown -R squeezeboxserver:nogroup /var/lib/squeezeboxserver/prefs/ && \
    chown -R squeezeboxserver:nogroup /var/log/squeezeboxserver/ && \
    chown -R squeezeboxserver:nogroup /usr/share/squeezeboxserver/ && \
    mkdir -p /var/music && \
    chown -R squeezeboxserver:nogroup /var/music && \
    mkdir -p /media/music && \
    ln -s /var/music/ /media && \
    apt-get clean autoclean autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    rm /tmp/logitechmediaserver_7.8.0_all.deb

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

