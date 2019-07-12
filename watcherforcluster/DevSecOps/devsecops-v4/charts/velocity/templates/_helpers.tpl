{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "velocity.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "velocity.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "velocity.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Creating domain names to be used by services
*/}}
{{- define "root.url.appHome" -}}
    {{- if not .Values.url.domain -}}
      {{- printf "$(HOME_URL)" -}}
    {{- else -}}
      {{- if .Values.ingress.enabled -}}
        {{- $ingressPath := .Values.ingress.path | trimSuffix "/" -}}
        {{- printf "%s://%s%s" .Values.url.protocol .Values.url.domain $ingressPath -}}
      {{- else -}}
        {{- printf "%s://%s" .Values.url.protocol .Values.url.domain -}}{{- if .Values.url.port -}}{{- printf ":%g" .Values.url.port -}}{{- end -}}
      {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "root.url.reportingUi" -}}
  {{- $servicePath := "reports" -}}
  {{- include "root.url.appHome" . -}}{{- printf "/%s" $servicePath -}}
{{- end -}}

{{- define "root.url.cr" -}}
  {{- $servicePath := "deploymentPlans" -}}
  {{- include "root.url.appHome" . -}}{{- printf "/%s" $servicePath -}}
{{- end -}}

{{- define "root.url.securityAuth" -}}
  {{- $servicePath := "security-api/auth" -}}
  {{- include "root.url.appHome" . -}}{{- printf "/%s" $servicePath -}}
{{- end -}}

{{- define "root.url.securityApiHost" -}}
  {{- $servicePath := "security-api" -}}
  {{- include "root.url.appHome" . -}}{{- printf "/%s" $servicePath -}}
{{- end -}}

{{- define "root.url.mapApi" -}}
  {{- $servicePath := "multi-app-pipeline-api" -}}
  {{- include "root.url.appHome" . -}}{{- printf "/%s" $servicePath -}}
{{- end -}}

{{- define "root.url.releaseEventsApi" -}}
  {{- $servicePath := "release-events-api" -}}
  {{- include "root.url.appHome" . -}}{{- printf "/%s" $servicePath -}}
{{- end -}}

{{- define "root.url.reportingConsumer" -}}
  {{- $servicePath := "reporting-consumer" -}}
  {{- include "root.url.appHome" . -}}{{- printf "/%s" $servicePath -}}
{{- end -}}

{{- define "rabbitmq.url" -}}
  {{- if not .Values.rabbitmq.url -}}
    {{- printf "amqp://%s:%s@" .Values.rabbitmq.user .Values.rabbitmq.password -}}{{- printf "velocity-rabbitmq:5672/" -}}
  {{- else -}}
    {{- printf .Values.rabbitmq.url -}}
  {{- end -}}
{{- end -}}

{{- define "mongo.host" -}}
  {{- if .Values.mongodb.existingdbHost -}}
    {{ .Values.mongodb.existingdbHost }}
  {{- else -}}
    {{- printf "%s-mongodb" .Release.Name -}}
  {{- end -}}
{{- end -}}


{{- define "mongodb.url" -}}
      {{- if and .Values.mongodb.usePassword .Values.mongodb.mongodbUsername .Values.mongodb.mongodbPassword -}}
          {{- printf "mongodb://%s:%s@%s:%g" .Values.mongodb.mongodbUser .Values.mongodb.mongodbPassword (include "mongo.host" . ) .Values.mongodb.service.port -}}{{- if .Values.mongodb.mongodbDatabase -}}{{- printf "/%s" .Values.mongodb.mongodbDatabase -}}{{- end -}}
      {{- else -}}
          {{- printf "mongodb://%s:%g" (include "mongo.host" . ) .Values.mongodb.service.port -}}{{- if .Values.mongodb.mongodbDatabase -}}{{- printf "/%s" .Values.mongodb.mongodbDatabase -}}{{- end -}}
      {{- end -}}
{{- end -}}


{{- define "mongodb.test.command" -}}
  {{- printf "until nc -z -w 10 %s %g ; do echo \"Waiting for mongodb\" ; sleep 10 ; done;" (include "mongo.host" . ) .Values.mongodb.service.port -}}
{{- end -}}


{{- define "pod.imagePullSecrets" -}}
{{- if .Values.global.imagePullSecrets }}
imagePullSecrets:
  {{- range .Values.global.imagePullSecrets }}
  - name: {{ . }}
  {{- end }}
{{- else }}
imagePullSecrets: []
{{- end -}}
{{- end -}}