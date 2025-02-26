# Persistent volume
The `pv.yaml` file is an example of pv definition.
To make it work adjust the path (to an empty folder), and value for node selector (e.g. for Docker Desktop, set it to `docker-desktop`).
For a more complex k8s deployment the whole `nodeAffinity` block might need to be adjust.

# Secret
## Storing keys

The `wallet-secret.yaml` file contains the example of storing the BLS and ECDSA keys along password in k8s secrets.
It should not be use in production, as secrets are not really secure.

Below links to more mature solutions:
- [vault](https://github.com/hashicorp/vault)
- [sealed-secrets](https://github.com/bitnami-labs/sealed-secrets)
- [sops](https://github.com/getsops/sops)
