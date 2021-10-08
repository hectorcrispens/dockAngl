FROM node:fermium-slim
WORKDIR /angl

# Configuracion de git
ARG NAME=name
ARG EMAIL=name@youremail.com

# Gestion de usuario del contenedor
ARG USER=dockangl
ARG PW=dockangl

RUN groupadd ${USER}
RUN useradd  ${USER} -g ${USER}

RUN chpasswd "${USER}:${PW}"


RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y apt-utils \
  curl \
  git \
  zip && \
  git config --global user.email "${EMAIL}" && \
  git config --global user.name "${NAME}" && \
  npm install -g @angular/cli

USER ${USER}

EXPOSE 4200
