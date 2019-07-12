#!/bin/bash

# Usage: getServiceEndpoints.sh <solution-name> <release-name> <namespace> [timeout]

set -e 

SOLUTION_NAME=$1
RELEASE_NAME=$2
NAMESPACE=$3
#TIMEOUT=${4:-20} # 20 second default timeout if not specified
TIMEOUT=90

echo 'executing getserviceEndPoint**********************************'

echo $TIMEOUT
# Get the Solution IP and wait if necessary
ROOTDIR=`dirname "$0"`
SOLUTIONIP=`$ROOTDIR/getSolutionIP.sh ${SOLUTION_NAME} ${RELEASE_NAME} ${NAMESPACE} ${TIMEOUT}`
if [ $? -ne 0 ]; then
   echo Solution IP not found && exit 1
fi

# Get the entire service json
SERVICEJSON=`kubectl get service -o json ${RELEASE_NAME}-${SOLUTION_NAME} --namespace ${NAMESPACE}`

# If the ports section contains "https" then we choose that as the scheme
PORTS=`echo $SERVICEJSON | jq -r '.spec.ports'`
SCHEME=http
if [[ "$PORTS" == *https* ]]; then
    SCHEME=https
fi

# Get the list of route names, by doing the following:
#  1. Echoing the servicejson
#  2. Use jq to pull out the "getambassador.io/config" annotation from the service
#  3. Use grep to pull out all strings that look like "host: foo"
#  4. Use cut to remove the "host: " from the matches returned from grep
ROUTENAMES=`echo $SERVICEJSON | jq -r '.metadata.annotations."getambassador.io/config"' | grep -iEo "host:[^\\]*" | cut -c7-`

# Construct the URLs
while read -r ROUTE; do
    echo ${SCHEME}://$ROUTE.$SOLUTIONIP.nip.io
done <<< "$ROUTENAMES"

