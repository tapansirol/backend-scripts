#!/bin/bash

set -e
cd /tmp/copyToJenkinsPod/
tar -zxvf jenkinsMagic.tgz
mv jenkins-integration /tmp/
mkdir -p /var/jenkins_home/init.groovy.d
cp /tmp/jenkins-integration/groovy-scripts/* /var/jenkins_home/init.groovy.d/
cp /tmp/jenkins-integration/downloads/* /var/jenkins_home/
cp /tmp/copyToJenkinsPod/pipeline.properties /var/jenkins_home/init.groovy.d/
cp /tmp/jenkins-integration/conf/*.xml /var/jenkins_home/
cp /var/jenkins_home/*.hpi /var/jenkins_home/plugins
mkdir -p /var/jenkins_home/onetest
cp /tmp/copyToJenkinsPod/onetest/* /var/jenkins_home/onetest/
