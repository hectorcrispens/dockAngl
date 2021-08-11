FROM node:fermium-slim
WORKDIR /angl

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y apt-utils \
  curl \
  git \
  zip && \
  git config --global user.email "you@example.com" && \
  git config --global user.name "Your Name" && \
  npm install -g @angular/cli

EXPOSE 4200
