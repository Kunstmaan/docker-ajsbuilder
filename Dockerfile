FROM node:4

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
COPY Gemfile /usr/src/app/

RUN apt-get -qq update \
        && apt-get install -qq -y build-essential rubygems ruby-dev \
        && gem install bundler --quiet \
        && bundle install \
        && npm set progress=false \
        && npm install -g gulp bower --silent \
        && npm install --silent \
        && apt-get -qq -y autoremove \
        && apt-get -qq -y clean \
        && rm -rf /var/lib/apt/lists/*

CMD [ "/bin/bash" ]
