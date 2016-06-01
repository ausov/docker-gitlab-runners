FROM gitlab/gitlab-runner:ubuntu

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV JAVA_VERSION 8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Enable Oracle JDK8 PPA by webupd8team
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list
RUN echo oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

# Enable PHP7 PPA by ondrej
RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" | tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

# Enable Node.js 4 from Nodesource
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -

# Run updates
RUN apt-get update && apt-get dist-upgrade -y

# Install utilities
RUN apt-get install -y zip unzip build-essential

# Install development libs
RUN apt-get install -y libxml2-dev libxslt1-dev
#RUN apt-get install -y xvfb libsqlite3-dev libxext6 xfonts-75dpi fontconfig libxrender1 xfonts-base

# Install Python
RUN apt-get install -y python python-dev libpcre3-dev

# Install Node.js
RUN apt-get install -y nodejs
RUN npm install -g npm
RUN npm install -g node-gyp grunt gulp

# Install Java
RUN apt-get install -y --no-install-recommends \
  oracle-java${JAVA_VERSION}-installer \
  oracle-java${JAVA_VERSION}-set-default \
  ca-certificates

# Install PHP
RUN apt-get install -y php7.0 php7.0-sqlite php7.0-mysql php7.0-curl php7.0-gd php7.0-gmp php7.0-mcrypt php7.0-intl php7.0-dev php7.0-xsl php7.0-xml php7.0-bcmath php-pear

# Cleanup
RUN apt-get autoclean && apt-get --purge -y autoremove && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
