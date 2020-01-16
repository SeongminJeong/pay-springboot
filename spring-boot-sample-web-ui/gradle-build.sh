#!/bin/bash

set -e

if (( $# != 1 ))
then
    echo "Usage : gradle-build.sh [version] " 1>&2
    exit 1
fi


APP_VERSION=$1


./gradlew clean build -PprojVersion=${APP_VERSION}