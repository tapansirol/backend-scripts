#!/bin/bash

file="/var/jenkins_home/init.groovy.d/pipeline.properties"

TEST_FILE_PATH='/var/jenkins_home/onetest/jpetstore-demo.zip'
VARFILE_PATH='/var/jenkins_home/onetest/varfile.xml'
WORKSPACE_NAME='jpetstore-demo'
PROJECT_NAME='jpetstore-demo'
TEST_NAME='campaigntest'

if [ -f "$file" ]
then
    echo "$file found."

SERVICE_URL=`sed '/^\#/d' $file | grep 'ONETEST_SERVICE_NAME'  | tail -n 1 | cut -d "=" -f2- | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'`
# podname=`sed '/^\#/d' $file | grep 'POD_NAME'  | tail -n 1 | cut -d "=" -f2- | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'`

echo One test URL = $SERVICE_URL
# echo database pass = $podname
#SERVICE_URL='http://35.231.101.99'

else
    echo "$file not found."
fi

#
#
echo "***** deleting the existing workspace ${WORKSPACE_NAME} from ${SERVICE_URL}"
#
#

delresponse=$(curl -X DELETE -H "Content-Type: application/x-www-form-urlencoded" -H "Accept: application/json" "$SERVICE_URL/workspaces/$WORKSPACE_NAME")

echo 'Response from delete existing workspace:' $delresponse

#
#
echo "****** creating workspace with provided test zip file ******" 
#
#

response=$(curl -k -i -F "file=@$TEST_FILE_PATH" -X POST -H "Content-type: multipart/form-data" {"type":"formData"}  "$SERVICE_URL/workspaces/" | grep "Location" | cut -d ":" -f2 | awk '{$1=$1};1')
echo 'Response from create workspace:' $response
statusurl=$SERVICE_URL$response
echo "$statusurl"
url=${statusurl%$'\r'}

TIMEOUT=${2:-120} # 60 second default timeout if not specified
DURATION="0"
STATUS="NEW"
while [ $DURATION -lt $TIMEOUT ]; do
	 STATUS=$(curl -k -X GET --header "Accept: application/json" "$url" | 
python -c "
import sys, json		
status =json.load(sys.stdin)['status']
print(status)
")

if [ "$STATUS" == "COMPLETED" ] || [ "$STATUS" != "IN_PROGRESS" ] ; then
		break
	fi
	echo "$STATUS"
	sleep 10
	DURATION=$[$DURATION+1]
done
echo "Test scripts file uploaded with status: $STATUS"

echo "****** uploading varfile to substitute the url for deployed application ******"

puturl="$SERVICE_URL/workspaces/$WORKSPACE_NAME/$PROJECT_NAME"
echo url for uploading varfile $puturl

# uploadresponse=$(curl -k -i -F "varfile=@/home/jagan/sofyonetest/varfile.xml" -X PUT -H "Content-type: multipart/form-data" {"type":"formData"} "http://35.231.101.99/workspaces/jpetstore-test/jpetstore-test")
uploadresponse=$(curl -k -i -F "varfile=@$VARFILE_PATH" -X PUT -H "Content-type: multipart/form-data" {"type":"formData"} "$SERVICE_URL/workspaces/$WORKSPACE_NAME/$PROJECT_NAME")
echo $uploadresponse

#
echo "***** execute the test from workspace ******"
#
#
#

echo "Test execution on ${SERVICE_URL}/executions"

response=$(curl -k -i -X POST -H "Content-type: application/json" -H "Accept: application/json" -d '{"workspaceName":"'"$WORKSPACE_NAME"'","project":"'"$PROJECT_NAME"'","test":"'"$TEST_NAME"'","varfile":"varfile.xml"}' "$SERVICE_URL/executions/" | grep "Location" | cut -d ":" -f2 | awk '{$1=$1};1')

echo 'Test Execution Response:' $response

statusurl=$SERVICE_URL$response
echo "$statusurl"
url=${statusurl%$'\r'}

TIMEOUT=${2:-120} # 60 second default timeout if not specified
DURATION="0"
STATUS="NEW"
while [ $DURATION -lt $TIMEOUT ]; do
         STATUS=$(curl -k -X GET --header "Accept: application/json" "$url" |
python -c "
import sys, json
status =json.load(sys.stdin)['status']
print(status)
")

        if [ "$STATUS" == "COMPLETED" ] || [ "$STATUS" != "IN_PROGRESS" ] ; then
                break
        fi
        echo "$STATUS"
        sleep 10
        DURATION=$[$DURATION+1]
done

if [ "$STATUS" == "COMPLETED" ]; then
	result=$(curl -k -i --output "/var/jenkins_home/onetest/$PROJECT_NAME.moeb.zip" "$url/log")
	echo $result
	reports=$(curl -k -i --output "/var/jenkins_home/onetest/$PROJECT_NAME.report.zip" "$url/report")
	echo $reports
fi

echo "Test scripts execution  with status: $STATUS"
#exit 1


