# Cluster config gitops module

Module to populate a gitops repository with base configuration of the Red Hat OpenShift cluster (notification banner, help menus, etc).

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v14
- kubectl

### Terraform providers

None

## Module dependencies

This module makes use of the output from other modules:

- Gitops - github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - github.com/cloud-native-toolkit/terraform-gitops-namespace.git

## Example usage

```hcl-terraform
module "cluster-config" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cluster-config.git"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  namespace = module.gitops_namespace.name
  kubeseal_cert = module.argocd-bootstrap.sealed_secrets_cert
  banner_text = var.banner_text
}
```

