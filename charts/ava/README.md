# ava Helm Chart

## Introduction

This repository contains a Helm chart for implementing the AVS called "ava".
More information about the AVS can be found in the [operator setup git repo](https://github.com/AvaProtocol/ap-operator-setup/tree/main).

## Table of Contents

- [ava Helm Chart](#ava-helm-chart)
  - [Introduction](#introduction)
  - [Table of Contents](#table-of-contents)
  - [Usage](#usage)
    - [Dependencies](#dependencies)
    - [Steps to Follow](#steps-to-follow)
  - [Configuration](#configuration)
  - [Troubleshooting](#troubleshooting)
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
   - [Ava Configs](https://github.com/AvaProtocol/ap-operator-setup/tree/main)
1. Store keys created in Step 1 in Kubernetes secrets.
_A simple, but insecure example how to do this can be found in the [example/wallet-secret.yaml](./example/wallet-secret.yaml) file.
Use it only for tests._
1. Make a copy the `values.yaml` file for the selected chain (holesky or mainnet).
E.g.:
    ```sh
    CHAIN=holesky
    NAME=ours
    cp values.${CHAIN}.yaml values.${NAME}.yaml
    ```
1. Ensure that the Persistent volume named 'ava' is created.
_For a help with a local test check the [example](./example/README.md) folder._
1. Fill the placeholders in the `values.${NAME}.yaml` file:
   - `YOUR_OPERATOR_ADDRESS`: the address of the AVS operator
   - `YOUR_BLS_KEY_SECRET`: the name of the secret where the BLS key is stored (see Step 2).
   - `YOUR_ECDSA_KEY_SECRET`: the name of the secret where the ECDSA key is stored (see Step 2).
   - consider adjusting `eth_rpc_url` and `eth_ws_url`
1. Run the following commands to install the chart.
    ```sh
    NAME=ours
    kubectl create ns ava
    cd $(git rev-parse --show-toplevel)/charts
    rm ava-*.tgz
    helm package ava
    helm install ava ava-*.tgz -n ava -f ava/values.${NAME}.yaml
    ```
All, but last commands are optional, and ensures that the installation won't fail.
If that is achieved in an alternative way, the installation can be done with this one command:
    ```
    helm install ava ava-*.tgz -n ava -f ava/values.${NAME}.yaml
    ```

Registration must be pass automatically via job register.

## Configuration

The following table lists the configurable parameters of the ava chart and their default values.

| Parameter                   | Description                                           | Default               |
| --------------------------- | ----------------------------------------------------- | --------------------- |
| `replicaCount`              | Number of replicas                                    | `1`                   |
| `service.type`              | Type of Kubernetes service                            | `ClusterIP`           |
| `service.ports`             | Service ports                                         | `{...}`               |
| `ingress.enabled`           | Enable ingress                                        | `false`               |
| `ingress.host`              | Ingress host                                          | `example.com`         |
| `node.image.repository`     | Node image repository                                 | `avaprotocol/ap-avs`  |
| `node.image.tag`            | Node image tag                                        | `latest`              |
| `node.image.pullPolicy`     | Image pull policy                                     | `Always`              |
| `node.resources.requests`   | CPU/Memory resource requests                          | `2 CPU / 8Gi Memory`  |
| `node.resources.limits`     | CPU/Memory resource limits                            | `4 CPU / 16Gi Memory` |
| `serviceAccount.create`     | Specifies whether a service account should be created | `true`                |
| `serviceAccount.name`       | Name of the service account                           | `""`                  |
| `register.enabled`          | Enable register functionality                         | `true`                |
| `register.image.repository` | Register image repository                             | `avaprotocol/ap-avs`  |
| `register.image.tag`        | Register image tag                                    | `latest`              |
| `register.image.pullPolicy` | Register image pull policy                            | `Always`              |
| `configs.operator.yaml`     | Operator configuration                                | `--`                  |

## Troubleshooting

If you encounter any issues during installation or usage, check the following:

- Ensure that all required Kubernetes resources are available.
- Validate your `values.yaml` file against the provided `values.schema.json`.
- Check the logs of the Helm deployment for any errors.

## Changelog

- 0.2.4 - better documentation
- 0.2.3 - accidental change (in line with all other)
- 0.2.2 - improve value files; better documentation
- 0.2.1 - remove scraper VM
- 0.2.0 - improve documentation and examples (first IvyNet version)
- 0.1.1 - change templates extension
- 0.1.0 - original chart

## Contributors

- wawrzek (Wawrzek Niewodniczanski) - wawrzek@ivynet.dev
- xom4ek (Aleksei Lazarev) - aleksei.lazarev@p2p.org (original work)

## License

This project is licensed under the MIT License. See the LICENSE file for details.
