#!/bin/bash

# Usage: waitForServices.sh <comma-seperated-list-of-service-urls> [timeout]

SERVICE_URLS=$1
TIMEOUT=${2:-60} # 60 second default timeout if not specified

DURATION="0"
while [ $DURATION -lt $TIMEOUT ]; do
  ALLGOOD="true"
  # Iterate over the comma-seperated list of service urls
  IFS=',' read -ra ADDR <<< "${SERVICE_URLS}"
  for i in "${ADDR[@]}"; do
    # If curl returns a 404, then break out of the loop
    RESPONSECODE=`curl -s -k -o /dev/null -w '%{http_code}' $i`
    if [[ ${RESPONSECODE} -eq 404 ]]; then
       ALLGOOD=
       break
    fi      
  done
  if [[ ${ALLGOOD} ]]; then
    echo $ALLGOOD
    exit
  fi
  sleep 1
  DURATION=$[$DURATION+1]
done
exit 1
