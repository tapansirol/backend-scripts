#!/bin/bash

# Usage: execOnPod <pod-prefix> <namespace> <commandToRun>
POD_PREFIX=$1
shift
NAMESPACE=$1
shift
COMMAND_TO_RUN=$@

POD_NAME=`kubectl get pods -o=name --namespace ${NAMESPACE} | grep ${POD_PREFIX}.* | cut -c5-`
kubectl exec --namespace ${NAMESPACE} ${POD_NAME} -- ${COMMAND_TO_RUN}