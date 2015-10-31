FROM mhart/alpine-node:0.12
MAINTAINER Hearst Automation Team <atat@hearst.com>

ENV HUBOT_HOME /opt/hubot

# Update and install necessary dependencies
RUN apk update && apk add \
    bash \
    supervisor \
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
COPY systemconfig.sh /tmp/systemconfig.sh

RUN mkdir -p /opt/hubot
RUN addgroup hubot && \
    adduser -h $HUBOT_HOME -D -s /bin/bash -G hubot hubot
COPY hubot.conf /hubot/opt/config/hubot.Conf

# Setup directories and permissions
RUN bash -c /tmp/systemconfig.sh

# Upgrade npm
RUN npm install --global npm@v2.14.9

# Install hubot
WORKDIR $HUBOT_HOME
RUN npm install --global coffee-script yo generator-hubot

USER hubot
# Install hipchat adapter by default
RUN yo hubot --owner="Bot Wrangler " --name="Hubot" --description="Delightfully aware robutt" --adapter=hipchat --defaults

# Configure default scripts
COPY external-scripts.json $HUBOT_HOME/external-scripts.json
RUN npm install --save hubot-pager-me \
hubot-plusplus \
hubot-tell \
hubot-devops-reactions \
hubot-team \
hubot-github-repo-event-notifier \
hubot-reload-scripts \
hubot-jenkins \
hubot-jenkins-notifier \
hubot-leankit
RUN npm install

# Expose volumes for long term data storage
VOLUME /var/lib/redis
VOLUME $HUBOT_HOME/config
VOLUME $HUBOT_HOME/scripts

USER root
CMD supervisord -n
