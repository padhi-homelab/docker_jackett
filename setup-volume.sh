#!/bin/sh -e

if [ -z "${ENTRYPOINT_RUN_AS_ROOT:-}" ]; then
    chown -R $DOCKER_USER:$DOCKER_GROUP /config /downloads
fi
