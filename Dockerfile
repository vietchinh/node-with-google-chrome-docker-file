FROM node:14-slim

ARG CHROME_STABLE_VERSION=88.0.4324.146-1
#when updating, get version here; https://www.ubuntuupdates.org/ppa/google_chrome
ENV CHROME_FILENAME=google-chrome-stable_${CHROME_STABLE_VERSION}_amd64.deb

RUN apt-get update -dy \
    && apt-get install -y wget gnupg gnupg2 gnupg1 \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& wget -q https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/${CHROME_FILENAME} \
    && apt-get -y remove gnupg gnupg2 gnupg1  \
	&& dpkg -i ${CHROME_FILENAME} || apt-get -y -f --no-install-recommends install \
	&& apt-get install -y --no-install-recommends libxss1 \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean \
	&& rm ${CHROME_FILENAME} \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \

# source for install specific chrome version: https://stackoverflow.com/questions/52217175/any-way-to-install-specific-older-chrome-browser-version
# source for installing chrome in docker https://github.com/markhobson/docker-node-chrome/blob/master/Dockerfile
