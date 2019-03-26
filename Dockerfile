FROM nvidia/cuda:9.2-cudnn7-devel-ubuntu16.04 as env

USER root

RUN apt-get update \
  && apt-get -y install wget locales git bzip2 curl \
  && rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen en_US.utf8 \
  && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8%

ENV LD_LIBRARY_PATH /usr/local/cuda/lib64

RUN apt-get update \
		&& apt-get -y install \
    libatlas-base-dev \
    libopencv-dev \
    libopenblas-dev \
  && rm -rf /var/lib/apt/lists/*

FROM sniper/env as prod

RUN apt-get update \
		&& apt-get -y install python-pip
 
RUN pip install opencv-python==3.2.0.8 \
    Cython \
    matplotlib==2.2.4 \
    numpy \
    scipy \
    pyyaml \
    EasyDict \
    protobuf \
    argparse \
    scikit-image \
    tqdm \
    futures\
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf ~/.cache/pip/*

ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/local/cuda/lib64
ENV PYTHONPATH /root/SNIPER/SNIPER-mxnet/python:/root/SNIPER/lib
