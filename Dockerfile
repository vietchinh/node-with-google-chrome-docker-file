FROM node:14

ARG CHROME_STABLE_VERSION
ENV CHROME_FILENAME=google-chrome-stable_${CHROME_STABLE_VERSION}_amd64.deb

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& wget -q https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/${CHROME_FILENAME} \
	&& apt-get update -qqy \
	&& dpkg -i ${CHROME_FILENAME} || apt-get -y -f install \
	&& apt-get install libxss1 \
	&& rm ${CHROME_FILENAME} \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \

# source for install specific chrome version: https://stackoverflow.com/questions/52217175/any-way-to-install-specific-older-chrome-browser-version
# source for installing chrome in docker https://github.com/markhobson/docker-node-chrome/blob/master/Dockerfile
