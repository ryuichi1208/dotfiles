FROM python:3.7-alpine

RUN apk --update add --no-cache \
    ansible \
    openssh \
    && mkdir /root/.ssh

WORKDIR /home

COPY ./playbook.yml .
