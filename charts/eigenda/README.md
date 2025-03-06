# EigenDA Helm Chart

## Introduction

This repository contains a Helm chart for Kubernetes, specifically for the AVS named "eigenda".
More information about the AVS can be found in the [operator setup git repo](https://github.com/Layr-Labs/eigenda-operator-setup).

## Table of Contents

- [eigenda Helm Chart](#eigenda-helm-chart)
  - [Introduction](#introduction)
  - [Table of Contents](#table-of-contents)
  - [Usage](#usage)
    - [Dependencies](#dependencies)
    - [Steps to Follow](#steps-to-follow)
  - [Configuration](#configuration)
    - [Global Parameters](#global-parameters)
    - [Service Parameters](#service-parameters)
    - [Ingress Parameters](#ingress-parameters)
    - [Configuration Parameters](#configuration-parameters)
    - [Register Container Parameters](#register-container-parameters)
    - [Node Container Parameters](#node-container-parameters)
    - [Pod Parameters](#pod-parameters)
    - [Service Account Parameters](#service-account-parameters)
  - [Example](#example)
  - [Changelog](#changelog)
  - [Contributors](#contributors)
  - [License](#license)

## Usage

### Dependencies

Ensure that Kubernetes and Helm are installed and configured.

This chart depends on several Kubernetes resources,e.g.: PV, secrets.
Deploy them in advance.
The [example](./example/README.md) folder contain basic implementation of required resources.


### Steps to Follow

1. Generate keys via the following URLs:
   - [Eigenlayer Operator Installation Guide](https://docs.eigenlayer.xyz/eigenlayer/operator-guides/operator-installation)
   - [EigenDA Configs](https://github.com/Layr-Labs/eigenda-operator-setup)
1. Store keys created in Step 1 in Kubernetes secrets.
_A simple, but insecure example how to do this can be found in the [example/wallet-secret.yaml](./example/wallet-secret.yaml) file.
Use it only for tests._
1. Make a copy the `values.yaml` file for the selected chain (only holesky at the moment).
E.g.:
    ```sh
    CHAIN=holesky
    NAME=ours
    cp values.${CHAIN}.yaml values.${NAME}.yaml
    ```
1. Ensure that the Persistent volume named 'eigenda' is created.
It has to have a few files and folder.
_For a help with a local test check the [example](./example/README.md) folder._
1. Fill the placeholders in the `values.${NAME}.yaml` file:
   - `YOUR_OPERATOR_ADDRESS`: the address of the AVS operator
   - `YOUR_BLS_KEY_SECRET`: the name of the secret where the BLS key is stored (see Step 2).
   - `YOUR_ECDSA_KEY_SECRET`: the name of the secret where the ECDSA key is stored (see Step 2).
   - consider adjusting `eth_rpc_url` and `eth_ws_url`
1. Run the following commands to install the chart.
    ```sh
    NAME=ours
    kubectl create ns eigenda
    cd $(git rev-parse --show-toplevel)/charts
    rm eigenda-*.tgz
    helm package eigenda
    helm install eigenda eigenda-*.tgz -n eigenda -f eigenda/values.${NAME}.yaml
    ```
All, but last commands are optional, and ensures that the installation won't fail.
If that is achieved in an alternative way, the installation can be done with this one command:
    ```
    helm install eigenda eigenda-*.tgz -n eigenda -f eigenda/values.${NAME}.yaml
    ```

Registration must be pass automatically via job register.

## Configuration

### Global Parameters

| Parameter          | Description                          | Default |
|--------------------|--------------------------------------|---------|
| `nameOverride`     | Optionally override the name of the chart | `""`    |
| `fullnameOverride` | Optionally override the full name of the chart | `""`    |
| `replicaCount`     | Number of replicas to deploy         | `1`     |
| `labels`           | Additional labels to add to resources | `{}`    |
| `imagePullSecrets` | Secrets for pulling images from a private registry | `[]`    |

### Service Parameters

| Parameter                | Description                          | Default       |
|--------------------------|--------------------------------------|---------------|
| `service.annotations`    | Annotations to add to the service    | `{}`          |
| `service.type`           | Type of service to create            | `ClusterIP`   |
| `service.ports`          | List of ports to expose from the service | `[]`          |

### Ingress Parameters

| Parameter                | Description                          | Default       |
|--------------------------|--------------------------------------|---------------|
| `ingress.annotations`    | Annotations to add to the ingress    | `{}`          |
| `ingress.enabled`        | Enable or disable the ingress        | `false`       |
| `ingress.host`           | Hostname for the ingress             | `example.com` |

### Configuration Parameters

| Parameter                   | Description                          | Default       |
|-----------------------------|--------------------------------------|---------------|
| `configs.operator.yaml`     | Configuration file for the operator  | `# some configs via file` |

### Register Container Parameters

| Parameter                         | Description                          | Default       |
|-----------------------------------|--------------------------------------|---------------|
| `register.enabled`                | Enable or disable the register container | `true`       |
| `register.image.repository`       | Image registry for the register container | `<IMAGE_REGISTRY>` |
| `register.image.pullPolicy`       | Image pull policy for the register container | `Always`      |
| `register.image.tag`              | Image tag for the register container | `<IMAGE_TAG>` |
| `register.args`                   | Arguments to pass to the register container | `["--config=/app/config/operator.yaml", "register-operator-with-avs"]` |

### Node Container Parameters

| Parameter                         | Description                          | Default       |
|-----------------------------------|--------------------------------------|---------------|
| `node.volumeMounts`               | Volume mounts for the node container | `[]`          |
| `node.image.repository`           | Image registry for the node container | `<IMAGE_REGISTRY>` |
| `node.image.pullPolicy`           | Image pull policy for the node container | `Always`      |
| `node.image.tag`                  | Image tag for the node container     | `<IMAGE_TAG>` |
| `node.ports`                      | Ports to expose from the node container | `[]`          |
| `node.resources`                  | Resource limits and requests for the node container | `{}`          |
| `node.env`                        | Environment variables for the node container | `[]`          |
| `node.args`                       | Arguments to pass to the node container | `[]`          |
| `node.readinessProbe`             | Readiness probe for the node container | `{}`          |
| `node.livenessProbe`              | Liveness probe for the node container | `{}`          |

### Pod Parameters

| Parameter                | Description                          | Default       |
|--------------------------|--------------------------------------|---------------|
| `nodeSelector`           | Node selector for the pod            | `{}`          |
| `tolerations`            | Tolerations for the pod              | `[]`          |
| `affinity`               | Affinity rules for the pod           | `{}`          |
| `podAnnotations`         | Annotations to add to the pod        | `{}`          |
| `podSecurityContext`     | Security context for the pod         | `{}`          |
| `securityContext`        | Security context for the container   | `{}`          |
| `volumes`                | Volumes for the pod                  | `[]`          |

### Service Account Parameters

| Parameter                    | Description                          | Default       |
|------------------------------|--------------------------------------|---------------|
| `serviceAccount.create`      | Specifies whether a service account should be created | `true`       |
| `serviceAccount.annotations` | Annotations to add to the service account | `{}`          |
| `serviceAccount.name`        | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `""`          |

## Example

To deploy the chart with custom values, create a `values.yaml` file:

```yaml
replicaCount: 2

service:
  type: LoadBalancer
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 8080

ingress:
  enabled: true
  host: myapp.example.com

register:
  image:
    repository: my-registry/my-register
    tag: latest

node:
  image:
    repository: my-registry/my-node
    tag: stable
  resources:
    limits:
      cpu: "2"
      memory: 2Gi
    requests:
      cpu: "1"
      memory: 1Gi
```

Then install the chart using the Helm CLI:

```sh
helm repo add p2p-avs https://p2p-org.github.io/avs-helm-charts/
helm upgrade -i  eigenda-release  p2p-avs/eigenda -f values.holesky.yaml
```

## Changelog
- 0.2.2 - better documentation
- 0.2.1 - update values schema
- 0.2.0 - update config to the 0.9.0 release; remove scraper VM
- 0.1.2 - chart as copied from Dora Factory fork

## Contributors

- wawrzek (Wawrzek Niewodniczanski) - wawrzek@ivynet.dev
- OsamaMomani

## License

This project is licensed under the MIT License. See the LICENSE file for details.
