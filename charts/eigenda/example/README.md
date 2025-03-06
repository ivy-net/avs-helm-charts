# Persistent volume
The `pv.yaml` file is an example of the PV definition.
To make it work adjust the path (to an existing folder), and value for node selector (e.g. for Docker Desktop, set it to `docker-desktop`).
The folder should contain the `g1.point` and `g2.point.powerOf2` as well the `logs` directory.
For a more complex k8s deployment the whole `nodeAffinity` block might need to be adjust.

# Secret
## Storing keys

The `wallet-secret.yaml` file contains the example of storing the BLS and ECDSA keys along password in k8s secrets.
It should not be use in production, as secrets are not really secure.

Below links to more mature solutions:
- [vault](https://github.com/hashicorp/vault)
- [sealed-secrets](https://github.com/bitnami-labs/sealed-secrets)
- [sops](https://github.com/getsops/sops)
