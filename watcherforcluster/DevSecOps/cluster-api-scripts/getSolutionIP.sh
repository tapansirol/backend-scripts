#!/bin/bash

# Usage: getSolutionIP.sh <solution-name> <release-name> <namespace> [timeout]

SOLUTION_NAME=$1
RELEASE_NAME=$2
NAMESPACE=$3
TIMEOUT=${4:-20} # 20 second default timeout if not specified

DURATION="0"
while [ $DURATION -lt $TIMEOUT ]; do
  SERVICEIP=`kubectl get service -o json ${RELEASE_NAME}-${SOLUTION_NAME} --namespace ${NAMESPACE} | jq -r '.status.loadBalancer.ingress[0].ip'`
  if [[ $SERVICEIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo $SERVICEIP
    exit 0;
  fi
  sleep 1
  DURATION=$[$DURATION+1]
done
echo Error: Solution IP not found in given timeout: ${TIMEOUT} seconds
exit 1