FROM resin/armv7hf-debian-qemu:latest
MAINTAINER Sebastian Schneider <mail@sesc.eu>

RUN [ "cross-build-start" ]

VOLUME /data

# Install yaml from apt, to also install the cpp lib.
RUN apt-get update && apt-get install -y \
    python3-dev \
    python3-pip \
    python3-yaml \
    python3-lxml \
    libxslt-dev \
    libxml2-dev \
    net-tools \
    nmap \
    build-essential \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Install home assistant
RUN pip3 install Adafruit_BBIO
RUN pip3 install netdisco
RUN pip3 install psutil
RUN pip3 install speedtest-cli
RUN pip3 install python-mpd2
RUN pip3 install python-nmap
RUN pip3 install fritzconnection
RUN pip3 install homeassistant

RUN find /usr/local/lib/
ADD bbb.patch /usr/local/lib/python3.4/dist-packages/homeassistant/
WORKDIR /usr/local/lib/python3.4/dist-packages/homeassistant
RUN patch -N -p1 < bbb.patch

WORKDIR /data

# Define default command
CMD ["hass", "--open-ui", "--config", "/data/.homeassistant"]

RUN [ "cross-build-end" ]

EXPOSE 8123


