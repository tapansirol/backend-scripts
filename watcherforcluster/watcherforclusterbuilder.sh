tar cvzf devsecops.tgz  DevSecOps/ devsecops-ui-0.0.1-SNAPSHOT.jar  
docker build -t watcherforcluster .
docker tag watcherforcluster tapansirole/watcherforcluster:test
docker push tapansirole/watcherforcluster:test
