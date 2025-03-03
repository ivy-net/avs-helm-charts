# ava Helm Chart

## Introduction

This repository contains a Helm chart for Kubernetes, specifically for the AVS named "ava".
More information about ava you can find here `https://github.com/AvaProtocol/ap-operator-setup/tree/main`

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

This chart depends on several Kubernetes resources (e.g. PV, secrets), and should be used in a Kubernetes cluster.

### Steps to Follow

1. Generate keys via the following URLs:
   - [Eigenlayer Operator Installation Guide](https://docs.eigenlayer.xyz/eigenlayer/operator-guides/operator-installation)
   - [Ava Configs](https://github.com/AvaProtocol/ap-operator-setup/tree/main)
1. Store keys created in Step 1 in Kubernetes secrets.
_A simple, but insecure example how to do this can be found in the [example/wallet-secret.yaml](./example/wallet-secret.yaml) file.
Use it only for tests._
1. Make a copy the `values.yaml` file for the selected chain (holesky or mainnet). E.g.:
    ```
    CHAIN=holesky
    NAME=ours
    cp values-${CHAIN}.yaml values-${NAME}.yaml
    ```
1. Ensure that the Persistent volume named 'ava' is created.
_For a help with a local test check the [example](./example/README.md) folder._
1. Fill the placeholders in the `values-${NAME}.yaml` file:
   - `YOUR_OPERATOR_ADDRESS`: the address of the AVS operator
   - `YOUR_BLS_KEY_SECRET`: the name of the secret where the BLS key is stored (see Step 2).
   - `YOUR_ECDSA_KEY_SECRET`: the name of the secret where the ECDSA key is stored (see Step 2).
   - consider adjusting `eth_rpc_url` and `eth_ws_url`
1. Run the following command to install the chart:
   ```sh
   helm install -i ava p2p-avs/ava -f values-${NAME}.yaml
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

- 0.2.0 - improvements to documentation and examples (first IvyNet version)
- 0.1.1 - change templates extensio
- 0.1.0 - orignal chart

## Contributors

- xom4ek (Aleksei Lazarev) - aleksei.lazarev@p2p.org
- dr\_nie (Wawrzek Niewodniczanski) - wawrzek@ivynet.dev

## License

This project is licensed under the MIT License. See the LICENSE file for details.
