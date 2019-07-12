#!/bin/bash

set -e

#echo "Generating Sonar Authentication Token"

SONAR_SERVER_URL=$1
#echo $1
pretty_sleep() {
  secs=${1:-180}
  tool=${2:-service}
  while [ $secs -gt 0 ]; do
    #echo -ne "$tool unavailable, sleeping for: $secs\033[0Ks\r"
    sleep 1
    : $((secs--))
  done
  echo "$tool was unavailable, so slept for: ${1:-60} secs"
}

#echo "* Waiting for the Sonar user token api to become available - this can take a few minutes"
TOOL_SLEEP_TIME=30
until [[ $(curl -k -I -s -u admin:admin -X POST ${SONAR_SERVER_URL}/api/user_tokens/generate|head -n 1|cut -d$' ' -f2) == 400 ]]; do pretty_sleep 10 Sonar; done

# Validating if token already exists:
USER_TOKEN=$(curl -k -u admin:admin -X POST ${SONAR_SERVER_URL}/api/user_tokens/search |
python -c "
import sys, json
def tokenExists(userTokens, token):
    if len(userTokens) == 0: return ''
    for t in userTokens:
        if t['name'] == token:
            return t['name']
    return ''
userTokens = json.load(sys.stdin)['userTokens']
print(tokenExists(userTokens, 'jenkins'))
")

echo $USER_TOKEN
SONAR_TOKEN=""

if [[ ! -z $USER_TOKEN ]]; then
  SONAR_TOKEN=$USER_TOKEN
  #echo "Sonar Auth Token exists already"
else
  SONAR_TOKEN=$(curl -k -u admin:admin -X POST ${SONAR_SERVER_URL}/api/user_tokens/generate?name=jenkins |
  python -c 'import sys,json; print(json.load(sys.stdin)["token"])')
  #echo "Generated Sonar Auth Token"
fi
export SONAR_AUTH_TOKEN=${SONAR_TOKEN}
echo "SonarToken"
echo $SONAR_AUTH_TOKEN

