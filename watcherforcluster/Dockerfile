FROM openjdk:8-jdk-alpine

# Dockerfile for HCL POWERSHIP self service portal
MAINTAINER Tapan Sirole

# Note: Latest version of the tools can be found at these locations:
#    Kubectl:     https://storage.googleapis.com/kubernetes-release/release/stable.txt
#    Helm/Tiller: https://github.com/kubernetes/helm/releases
ENV KUBE_VERSION="v1.13.4"
ENV HELM_VERSION="v2.13.1"

COPY devsecops.tgz /tmp

RUN apk update
RUN apk add python
RUN apk add curl
RUN apk add bash jq
RUN rm -rf /var/cache/apk/*
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
RUN wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz
RUN tar -xzvf helm-${HELM_VERSION}-linux-amd64.tar.gz -C /usr/local/bin --strip-components=1 linux-amd64/helm
RUN chmod +x /usr/local/bin/helm
RUN tar -xzvf helm-${HELM_VERSION}-linux-amd64.tar.gz -C /usr/local/bin --strip-components=1 linux-amd64/tiller
RUN chmod +x /usr/local/bin/tiller
RUN export HELM_HOST=:44134
RUN tiller &

RUN cd /home  && \
    tar xvfz /tmp/devsecops.tgz

RUN rm -r /tmp/devsecops.tgz

WORKDIR /home

EXPOSE 8888

CMD    ["java", "-jar", "devsecops-ui-0.0.1-SNAPSHOT.jar"]

