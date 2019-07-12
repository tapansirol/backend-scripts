#!/bin/bash

# Usage: copyFolderToPod <pod-prefix> <namespace> <local-dir> <remote-dir>
POD_PREFIX=$1
NAMESPACE=$2

POD_NAME=`kubectl get pods -o=name --namespace ${NAMESPACE} | grep ${POD_PREFIX}.* | cut -c5-`
kubectl delete pod ${POD_NAME} --namespace $2

