#!/bin/bash

# Usage: copyFolderToPod <pod-prefix> <namespace> <local-dir> <remote-dir>
# Prefix of the pod where files need to be copied
POD_PREFIX=$1

#namespace of the cluster where pod is running
NAMESPACE=$2

#local directory where folder is present
LOCAL_DIR=$3

#Remote directory is the location  of the pod where folder need to be copied
REMOTE_DIR=$4

echo "POD_PREFIX"
echo $POD_PREFIX

echo "NAMESPACE"
echo $NAMESPACE
echo "NAMESPACE"
echo $LOCAL_DIR
echo "LOCAL_DIR"
echo $REMOTE_DIR

POD_NAME=`kubectl get pods -o=name --namespace ${NAMESPACE} | grep ${POD_PREFIX}.* | cut -c5-`
echo 'Pod Name'
echo $POD_NAME
kubectl cp ${LOCAL_DIR} ${NAMESPACE}/${POD_NAME}:${REMOTE_DIR}
kubectl exec --namespace ${NAMESPACE} ${POD_NAME} -- bash -c 'sh /tmp/copyToJenkinsPod/setup-jenkins.sh'

