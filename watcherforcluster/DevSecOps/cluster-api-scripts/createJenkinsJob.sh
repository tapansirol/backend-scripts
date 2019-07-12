#!/bin/bash

set -e

JENKINS_SERVER_URL=$1
JOB_NAME=$2
CONFIG_FILE_PATH=$3
JENKINS_API_TOKEN=$4

echo "Creating Job in Jenkins"

#TOKEN=$(curl "${JENKINS_SERVICE_URL}/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken" --data "newTokenName=${JOB_NAME}" -u admin:admin) | grep "tokenValue" | cut -d ":" -f6 |  sed -e 's/}}$//'
#echo $TOKEN

RESULT=$(curl -s -XPOST ${JENKINS_SERVER_URL}/createItem?name=$JOB_NAME -k -u admin:$JENKINS_API_TOKEN --data-binary @${CONFIG_FILE_PATH} -H "Content-Type:text/xml")
echo $RESULT

