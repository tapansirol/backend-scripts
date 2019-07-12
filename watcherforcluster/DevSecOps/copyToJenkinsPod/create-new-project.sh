#!/bin/bash

set -e
PROJECT_NAME=$1
JENKINS_JOB_NAME=$2
JENKINS_SERVICE_NAME=$3
cp /tmp/copyProjectFiles/$PROJECT_NAME/* /var/jenkins_home/projects/$PROJECT_NAME/
cd /var/jenkins_home/projects/$PROJECT_NAME/
curl -s -XPOST "${JENKINS_SERVICENAME}/createItem?name=$JENKINS_JOB_NAME" -k -u admin:11f739776672eec1eaa3a3b911e5c5077d --data-binary @config.xml -H "Content-Type:text/xml"
