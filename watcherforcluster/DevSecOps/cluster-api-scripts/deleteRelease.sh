#!/bin/bash

# Usage: deleteRelease.sh <release-name>

RELEASE_NAME=$1

helm del --purge ${RELEASE_NAME}