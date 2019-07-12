#!/bin/bash

UCD_SERVICE_NAME=$1
NAMESPACE=$2
RELEASE_NAME=$3
AGENT_NAME="${RELEASE_NAME}-ucdagent"
echo $UCD_AGENT_NAME
#helm install --set UCD_SERVER_HOST=${UCD_SERVICE_NAME},UCD_AGENT_NAME=devsecops-agent-1 /home/DevSecOps/tomcat-and-ucdagent-0.1.0.tgz -n ucd-agent
helm install --set UCD_SERVER_HOST=${UCD_SERVICE_NAME},UCD_AGENT_NAME=${AGENT_NAME} /home/DevSecOps/tomcat-and-ucdagent-0.1.0.tgz -n ${AGENT_NAME} --namespace ${NAMESPACE}
