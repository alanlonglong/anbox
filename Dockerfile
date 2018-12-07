#!/bin/sh
FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
        build-essential \
        cmake \
        cmake-data \
        cmake-extras \
        debhelper \
        dbus \
        dbus-x11 \
        git \
        google-mock \
        libboost-dev \
        libboost-filesystem-dev \
        libboost-log-dev \
        libboost-iostreams-dev \
        libboost-program-options-dev \
        libboost-system-dev \
        libboost-test-dev \
        libboost-thread-dev \
        libcap-dev \
        libegl1-mesa-dev \
        libgles2-mesa-dev \
        libglib2.0-dev \
        libglm-dev \
        libgtest-dev \
        liblxc1 \
        libproperties-cpp-dev \
        libprotobuf-dev \
        libsdl2-dev \
        libsdl2-image-dev \
        libsystemd-dev \
        lxc-dev \
        pkg-config \
        protobuf-compiler \
        iproute2 \
        iptables \
        kmod \
        x11-apps
    # apt-get clean

WORKDIR /anbox

# cleanup() {
#   # In cases where anbox comes directly from a checked out Android
#   # build environment we miss some symlinks which are present on
#   # the host and don't have a valid git repository in that case.
# clear


#if [ -d .git ] ; then
#    admp
#ls git clean -fdx .
#     git reset --hard
#  ad fi
# }
# cleanup
#COPY CMakeLists.txt CMakeLists.txt 
#COPY src src
COPY . /anbox
RUN mkdir build || rm -rf build/*
RUN ls
WORKDIR /anbox/build
RUN cmake ..
RUN VERBOSE=1 make -j10
RUN VERBOSE=1 make test
RUN make install 
ENV ANBOX_LOG_LEVEL='trace'
#RUN export $(dbus-launch)
# VERBOSE=1 make test
# todo - use wget to get a version controlled android image.
#COPY android.img /var/lib/anbox/android.img
#ENTRYPOINT ["anbox container-manager --daemon --privileged --data-path=/var/lib/anbox"]

#docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw"  -v /mnt/store/android_images:/var/lib/anbox/ --privileged  -v /tmp/.X11-unix:/tmp/.X11-unix local:anbox /bin/bash