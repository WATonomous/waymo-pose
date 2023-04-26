FROM nvidia/cuda:11.0.3-devel-ubuntu20.04
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /setup

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

# python
RUN apt-get update -y
ENV http_proxy $HTTPS_PROXY
ENV https_proxy $HTTPS_PROXY

RUN apt-get install -y software-properties-common && add-apt-repository ppa:deadsnakes/ppa && apt-get update && apt-get install -y \
    python3.7 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

###### Install Dependencies Here ########

#########################################

# fix user permissions when deving in container
COPY docker/fixuid_setup.sh /project/fixuid_setup.sh
RUN /project/fixuid_setup.sh
USER docker:docker
WORKDIR /home/docker/

ENV DEBIAN_FRONTEND interactive

ENTRYPOINT ["/usr/local/bin/fixuid"]
CMD ["sleep", "inf"]
