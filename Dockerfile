FROM debian:latest
MAINTAINER Antoine Henning <henning.antoine@gmail.com>

# Get dependencies
RUN apt-get update && apt-get install -y \
        git \
        python python-pip \
        python-numpy \
        python-scipy \
        python-matplotlib \
        python-pandas && \
    rm -rf /var/lib/apt/lists/* && \
    pip install scikit-learn==0.17.1

# Installation
RUN mkdir /home/vmaf && cd /home/vmaf && \
    git clone https://github.com/Netflix/vmaf . && \
    make

# Testing
RUN export PYTHONPATH=/home/vmaf/python:$PYTHONPATH && \
    cd /home/vmaf && \
    ./unittest

CMD ["bash"]
