## IvyNet Helm Charts for Kubernetes

_This repository based on the previous work from P2P as well as DoraFactory._
_For original work check:_
* _https://github.com/p2p-org/avs-helm-charts_
* _https://github.com/DoraFactory/avs-helm-charts_

It offers a selection of Helm charts for AVS.
Each chart is stored in a separate folder and has own `values.yaml` file defining the configuration parameters.

IvyNet has been working on following:
* [Ava](./charts/ava)
* [EigenDA](./charts/eigenda)

There are a few more not reviewed yet:

* [Aethos (Predicate now)](./charts/aethos)
* [ARPA](./charts/arpa)
* [k3](./charts/k3)
* [lagrange](./charts/lagrange)
* [openoracle](./charts/openoracle)
* [radius](./charts/radius)

## Getting Started

### Requirements

Before you can use these Helm charts, ensure you have the following:

* Kubernetes 1.20 or higher
* Helm 3
* PV provisioner support in the underlying infrastructure (required for some charts)


### Quick start

Currently, the charts have to be build locally.
```sh
NAME=ava
cd charts
helm package ${NAME}
```

Next, the configuration (values file) should be prepared based on predefined configuration for holesky or mainnet chain.
Finally pre installation step is deployment fo the k8s resources which are not part of a chart (e.g. PV, or secrets).

Once the chart is packed, configured and its dependencies fulfilled, it can be deployed;
```sh
helm install ${NAME} ${NAME}-*.tgz -n ${NAME}
```

### Helm

For detailed guidance on using Helm, see the [official documentation](https://helm.sh/docs/intro/using_helm/).

Here's a selection of helpful Helm commands to kickstart your journey:

* Check values file of a chart: `helm lint --values ava/values.ours.yaml`
* Package a chart: `helm pacakge ava`
* Install a chart: `helm install ava ava-0.2.1.tgz -f ava/values.ours.yaml -n ava`
* Upgrade an application: `helm upgrade ava ava-0.2.2.tgz -f ava/values.ours.yaml -n ava`
