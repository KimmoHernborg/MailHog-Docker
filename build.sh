#!/usr/bin/env bash

# Log oneliner
log () { LOG_LEVEL=$2; if [ ! $LOG_LEVEL ]; then LOG_LEVEL="info"; fi; echo -e "\033[38;5;131m[${LOG_LEVEL}] \033[38;5;147m$1\033[0m"; }

# Variables
IMAGE_NAME="kimmohernborg/mailhog-docker"
TAG="latest"
if [[ $1 != "" ]]; then EXECUTE=true; else EXECUTE=false; fi
#echo "EXECUTE = $EXECUTE"

log "Build '$IMAGE_NAME:$TAG'" "build"
if $EXECUTE; then docker build --pull -t "$IMAGE_NAME:$TAG" .; fi
echo

log "Push '$IMAGE_NAME:$TAG'" "push"
if $EXECUTE; then docker push "$IMAGE_NAME:$TAG"; fi
echo
