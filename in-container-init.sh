#!/bin/bash

apt update -y

yes | unminimize

apt install -y man-db

apt install -y ./siakhooi-devutils-date-formats_1.0.1_amd64.deb
