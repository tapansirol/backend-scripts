# HCL UrbanCode Velocity SE (Standard Edition)

UrbanCode Velocity is an enterprise-scale release management service that supports both cloud-native and on-premises deployment tools. You can integrate your release with Jira, ServiceNow, and deployment risk analysis tasks.

## TL;DR;

```bash
$ helm install <hcl-charts-repo>/velocity --set access.key=<valid-access-key>
```

## Introduction

This chart boots a UC Velocity SE deployment on a (Kubernetes)[http://kubernetes.io/] cluster using the (Helm)[https://helm.sh/] package manager.

## Prerequisites

You will need a valid access key. You can also use a (60-days)[https://uc-velocity.com/] trial key.

### Installation

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release <hcl-charts-repo>/velocity  --set access.key=<valid-access-key>
```

This command will install Velocity on the Kubernetes cluster in the default configuration. The (configuration)[#configuration] section lists the paramater that can be configured during installation.

Alternatively, you can create a custom `values.yaml` file and use it during the installation like:

```bash
$ helm install --name my-release <hcl-charts-repo>/velocity  -f custom-values.yaml
```

### Uninstallation

To uninstall/delete release `my-release`:

```bash
$ helm delete --purge my-release
```

## Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `license` | Accept/reject license | `accept` |
| `adminpassword` | Password required to login by `admin` | `admin` |
| `access.key` | The access key required to use UC Velocity | `` |
| `url.domain` | The domain where velocity will be hosted.  ```Optional``` | ``|
| `url.protocol` | HTTP Protocol associated with domain.  ```Required if url.domain is specified``` | `https` |
| `url.port` | The port associated with domain. ```Required if url.domain is specified```  | `` |
| `rabbitmq.url` | The URL to access a RabbitMQ instance.  ``` Optional, if not provided, one will be deployed automatically. ``` | `` |
| `rabbitmq.nodeport` | The nodeport value which will be used for RabbitMQ service | `31672` |
| `rabbit.managerPort` | The port to expose RabbitMQ stats | `15672` |
| `rabbitmq.erlangCookie` | RabbitMQ ERL cookie value | `128ad9b8-3d9f-11e8-b467-0ed5f89f718c` |
| `rabbitmq.user` | RabbitMQ user name | `rabbit` |
| `rabbitmq.password` | RabbitMQ user password | `carrot` |
| `apitoken` | The API token to access Velocity's REST API | `33ba769bd3439ac18ba85c851af0c2931583cf76b3a0a4ef4db6f4181515e8a8b33a0a36235902b4f6707865` |
| `ciphertoken` | Cipher key token | `acef0b7174b45fffbe091c1737597814` |
| `hmackey` | HMAC key token | `ac60e2d65928fbfd5c72cd49c3fc1f01` |
| `loglevel` | Granularity of logs exported by container | `ALL` |
| `ingress.enabled` | Enable ingress resource | `false` |
| `ingress.path` | The routing path | `\` |
| `images.application_api` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/products/uc-velocity/application-api:1.0.359'` |
| `images.continuous_release_consumer` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/products/uc-velocity/continuous-release-consumer:1.0.172'` |
| `images.continuous_release_poller` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/products/uc-velocity/continuous-release-poller:1.0.18'` |
| `images.continuous_release_ui` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/products/uc-velocity/continuous-release-ui:1.0.177'` |
| `images.multi_app_pipeline_api` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/products/uc-velocity/multi-app-pipeline-api:1.0.120'` |
| `images.reporting_consumer` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/products/uc-velocity/reporting-consumer:1.0.125'` |
| `images.reporting_sync_api` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/products/uc-velocity/reporting-sync-api:1.0.31'` |
| `images.reporting_ui` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/products/uc-velocity/reporting-ui:1.0.84'` |
| `images.release_events_api` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/products/uc-velocity/release-events-api:1.0.389'` |
| `images.release_events_ui` | The docker container image path | `gcr.io/blackjack-209019/blackjack/products/uc-velocity/release-events-ui:1.0.422'` |
| `images.security_api` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/products/uc-velocity/security-api:1.0.101'` |
| `images.rabbitmq` | The docker container image path | `'bitnami/rabbitmq:3.7.9'` |
| `images.nginx` | The docker container image path | `'bitnami/nginx:1.14'` |
| `images.domainMapper` | The docker container image path | `'gcr.io/blackjack-209019/blackjack/domain-mapper:0.1.0'` |
| `global.imagePullSecrets` | The image secret names, required to pull access controlled docker registries | `{}` |
| `mongodb.existingdbHost` | The host name of existing Mongodb instance. | `` |
| `mongodb.install` | Install Mongodb | `true` | 
| `mongodb.persistence.enabled` | Use a PVC to persist data | `true` |
|  `mongodb.persistence.existingclaim` | An existing  PVC name | `` |
| `mongodb.persistence.size` | The size allocated to PVC | `8Gi` |
| `mongodb.persistence.storageClass` | The storage class name of PV to be used | `nil` |
| `mongodb.service.type` | The service type of Mongodb | `ClusterIP` |
| `mongodb.service.port` | The port for Mongodb service | `27017` |
| `mongodb.usePassword` | Secure Mongodb access | `false` |
| `mongodb.mongodbRootPassword` | Admin password for Mongodb ```Optional, set only if mongodb.usePassword=true``` | `nil` |
| `mongodb.mongodbUsername` | Username for Mongodb ```Optional, set only if mongodb.usePassword=true``` |`nil` |
| `mongodb.mongodbPassword` | Password for Mongodb ```Optional, set only if mongodb.usePassword=true``` |`nil` |
| `mongodb.mongodbDatabase` | Initial database for Mongodb ```Optional, set only if mongodb.usePassword=true``` |`nil` |

## Notes

- Ensure that the cluster where UC Velocity will be deployed has at least 4 nodes, and ideally autoscaler enabled.

- If you do not provide `url.domain`, it is assumed that Velocity is proxied behind an [Ambassador](https://getambassador.io) instance, and Velocity will try to determine it's domain/externalIP.

- If you have an ingress controller present, set `ingress.enabled` to `true`. Also, the ingress controller should have HTTPS enabled.

## License

(c) Copyright HCL Technologies Ltd. 2019 All rights reserved.