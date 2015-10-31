FROM alpine:edge
MAINTAINER Hearst Automation Team <atat@hearst.com>

ENV HUBOT_HOME /opt/hubot

# Update and install necessary dependencies
RUN apk update && apk add \
    bash \
    supervisor \
    nodejs \
    redis \
    build-base \
    gcc \
    g++ \
    gcc-objc \
    libtool \
    libc6-compat \
    make \
    expat \
    expat-dev \
    python \
    wget \
    gnupg \
    tar \
    git \
    zip \
    curl \
    wget \
    && rm -rf /var/cache/apk/*

# Copy all files into place
COPY supervisord.conf /etc/supervisor.d/supervisord.ini
COPY hustart.sh $HUBOT_HOME/bin/hustart
COPY systemconfig.sh /tmp/systemconfig.sh

RUN mkdir -p /opt/hubot
RUN addgroup hubot && \
    adduser -h $HUBOT_HOME -D -s /bin/bash -G hubot hubot

# Setup directories and permissions
RUN bash -c /tmp/systemconfig.sh

#Upgrade npm
RUN npm install --global npm@v2.14.9

# Install hubot
WORKDIR $HUBOT_HOME
RUN npm install --global coffee-script yo generator-hubot

USER hubot
# Install hipchat adapter by default
RUN yo hubot --owner="Bot Wrangler " --name="Hubot" --description="Delightfully aware robutt" --adapter=hipchat --defaults
RUN npm install

# Expose volumes for long term data storage
VOLUME /var/lib/redis
VOLUME $HUBOT_HOME/scripts

USER root
CMD supervisord -n
