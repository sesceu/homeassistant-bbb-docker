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
#RUN pip3 install netdisco==0.5.5
RUN pip3 install python-mpd2==0.5.4
RUN pip3 install python-nmap==0.4.3
RUN pip3 install fritzconnection
RUN pip3 install homeassistant

WORKDIR /data

# Define default command
CMD ["hass", "--open-ui", "--config", "/data/.homeassistant"]

RUN [ "cross-build-end" ]

EXPOSE 8123


