#!/bin/bash

set -e

#build image
docker build -t alpine-base-amd64:`cat Version` .