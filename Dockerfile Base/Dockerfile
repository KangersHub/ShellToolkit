FROM ubuntu:latest

# LABEL 
LABEL org.opencontainers.image.source="https://github.com/kangershub/shelltoolkit"

# ENV
ENV TZ Asia/Kolkata
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

# Install all the required packages
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# install required packages
RUN apt-get -y update && apt-get -y upgrade && \
        apt-get install -y software-properties-common aria2 \
        jq pv gcc g++ ffmpeg nginx \
        mediainfo mkvtoolnix python-dev python3 python3-pip python3-lxml \
        neofetch python3-dev git bash build-essential nodejs npm ruby \
        locales python-lxml qbittorrent-nox gettext-base xz-utils \
        p7zip-full p7zip-rar rar unrar zip unzip lshw \
        g++ gcc automake autoconf libtool libcurl4-openssl-dev \
        qt5-default libsodium-dev libssl-dev libcrypto++-dev libc-ares-dev \
        libsqlite3-dev libfreeimage-dev swig libboost-all-dev \
        libpthread-stubs0-dev zlib1g-dev \
        curl git gnupg2 unzip wget pv jq \
        megatools mediainfo

RUN add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable

# rclone ,gclone and fclone
RUN curl https://rclone.org/install.sh | bash && \
    aria2c https://git.io/gclone.sh && bash gclone.sh && \
    aria2c https://github.com/mawaya/rclone/releases/download/fclone-v0.4.1/fclone-v0.4.1-linux-amd64.zip && \
    unzip fclone-v0.4.1-linux-amd64.zip && mv fclone-v0.4.1-linux-amd64/fclone /usr/bin/ && chmod +x /usr/bin/fclone && rm -r fclone-v0.4.1-linux-amd64

#drive downloader
RUN curl -L https://github.com/jaskaranSM/drivedlgo/releases/download/1.5/drivedlgo_1.5_Linux_x86_64.gz -o drivedl.gz && \
    7z x drivedl.gz && mv drivedlgo /usr/bin/drivedl && chmod +x /usr/bin/drivedl && rm drivedl.gz

#ngrok
RUN aria2c https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && unzip ngrok-stable-linux-amd64.zip && mv ngrok /usr/bin/ && chmod +x /usr/bin/ngrok

#install rmega
RUN gem install rmega

# Installing Mega SDK Python Binding
ENV MEGA_SDK_VERSION="3.9.7"
RUN git clone https://github.com/meganz/sdk.git --depth=1 -b v$MEGA_SDK_VERSION ~/home/sdk \
    && cd ~/home/sdk && rm -rf .git \
    && autoupdate -fIv && ./autogen.sh \
    && ./configure --disable-silent-rules --enable-python --with-sodium --disable-examples \
    && make -j$(nproc --all) \
    && cd bindings/python/ && python3 setup.py bdist_wheel \
    && cd dist/ && pip3 install --no-cache-dir megasdk-$MEGA_SDK_VERSION-*.whl 

RUN apt-get -y update && apt-get -y upgrade && apt-get -y autoremove && apt-get -y autoclean

