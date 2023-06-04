# Docker file for base Neovim image.
FROM debian:sid-20211220

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TZ=America/Los_Angeles

RUN apt-get update && apt-get -y install curl \
    fzf ripgrep tree git xclip python3 python3-pip \
    tzdata gettext libtool libtool-bin autoconf automake \
    cmake g++ pkg-config zip unzip

RUN pip3 install pynvim

RUN mkdir -p /root/TMP
RUN cd /root/TMP && git clone https://github.com/neovim/neovim
RUN cd /root/TMP/neovim && git checkout stable && make -j4 && make install
RUN rm -rf /root/TMP

RUN mkdir -p /root/.local/share/nvim/site/spell
COPY ./spell/ /root/.local/share/nvim/site/spell/
RUN mkdir -p /root/.config

RUN git clone https://github.com/adibhanna/nvim.git
RUN mkdir -p /root/code

WORKDIR /root/code

CMD ["tail", "-f", "/dev/null"]
