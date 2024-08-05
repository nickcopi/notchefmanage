FROM ruby:2.1

# gpg keys listed at https://github.com/nodejs/node
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 5.12.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt

RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock config.ru Rakefile package.json npm-shrinkwrap.json /usr/src/app/
RUN bundle install

# Copy the typically static files over. These directories are not synced, so
# if you change them you'll need to rebuild the image using `docker-compose build`
COPY vendor/ /usr/src/app/vendor/
COPY public/ /usr/src/app/public/
COPY config/ /usr/src/app/config/
COPY cljs/ /usr/src/app/cljs/
COPY bin/ /usr/src/app/bin/

# Because we want the container to work even without mounted volumes, we copy over
# lib and app as well, even though they are mounted as volumes in our compose file.
COPY lib/ /usr/src/app/lib/
COPY app/ /usr/src/app/app/

# Copy the compose settings into the local slot
COPY config/settings/compose.yml /usr/src/app/config/settings.local.yml

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
