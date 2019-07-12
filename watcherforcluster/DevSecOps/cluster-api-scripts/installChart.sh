#!/bin/bash

set -e 

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

cd $SCRIPTPATH
# Usage: installChart.sh <chart-name> <release-name> <namespace>

echo "executing installchart.sh"
CHART_NAME=$1
RELEASE_NAME=$2
NAMESPACE=$3

echo "chart name"
echo $CHART_NAME
echo $RELEASE_NAME
echo "pwd"
echo $PWD
helm install /home/DevSecOps/devsecops-v4/ -n ${RELEASE_NAME} --namespace ${NAMESPACE}

