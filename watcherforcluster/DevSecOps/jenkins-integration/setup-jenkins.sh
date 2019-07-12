#!/bin/bash

set -e

tar -zxvf jenkinsMagic.tgz /tmp
mkdir -p /var/jenkins_home/init.groovy.d
cp tmp/jenkins-integration/groovy-scripts/* /var/jenkins_home/init.groovy.d/
cp tmp/jenkins-integration/downloads/* /var/jenkins_home/
cp tmp/jenkins-integration/pipeline.properties /var/jenkins_home/init.groovy.d/
cp tmp/jenkins-integration/conf /var/jenkins_home/
cp /var/jenkins_home/*.hpi /var/jenkins_home/plugins
