#!/bin/bash

function apt_update() {
  apt update && apt upgrade
}

function main() {
  apt_update
}

sudo main
