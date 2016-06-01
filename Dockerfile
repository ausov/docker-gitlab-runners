FROM gitlab/gitlab-runner:ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
  && apt-get update && apt-get dist-upgrade -y \
  && apt-get install -y git git-core wget curl zip unzip nano build-essential xvfb \
  && apt-get install -y oracle-java8-installer ca-certificates \
  && apt-get install -y nodejs npm \
  && apt-get install -y php7.0-sqlite php7.0-curl php7.0-gd php7.0-gmp php7.0-mcrypt php7.0-intl php7.0-dev php7.0-xsl php7.0-xml php7.0-bcmath php-pear \
  && apt-get install -y python libpcre3-dev \
  && apt-get install -y libsqlite3-dev libxext6 xfonts-75dpi fontconfig libxrender1 xfonts-base \
  && apt-get autoclean && apt-get --purge -y autoremove && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
