FROM node:fermium-slim

COPY script.sh /usr/local/bin/angl
RUN chmod +x /usr/local/bin/angl
WORKDIR /angl

# Configuracion de git
ARG NAME=name
ARG EMAIL=name@youremail.com

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y apt-utils \
  curl \
  git \
  zip && \
  git config --global user.email "${EMAIL}" && \
  git config --global user.name "${NAME}" && \
  npm install -g @angular/cli


EXPOSE 4200

ENTRYPOINT [ "angl" ]
