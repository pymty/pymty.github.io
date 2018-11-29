#!/bin/bash
set -e
BUILD_DIR=/workspace
if [ "$1" = 'debug' ]; then
    shift 2 # shift $0 and $1
    exec "$@"
else
    if [[ ! -d  "$BUILD_DIR" ]]; then
        echo "The bind mount to ${ BUILD_DIR } does not exist. " \
             "Verify that ${ $BUILD_DIR } exists." 2>&1
        exit 1
    else
        cd $BUILD_DIR
        ${VENV}/bin/nikola "$@"
    fi
fi
