# GitOps repo module

Module that prepares a GitOps repo for use with ArgoCD. If the `provision` flag is `true` then a new git repo will be provisioned. If not, the provided repo name is expected to already exist.

After cloning the git repo, an initial directory structure is set up along with bootstrap configuration to perform the initial setup of ArgoCD.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform >= v0.15
- git

### Terraform providers

- None

## Module dependencies

This module makes use of the output from other modules:

- None

## Example usage

```hcl-terraform
module "git" {
  source = "github.com/ibm-garage-cloud/terraform-tools-argocd.git?ref=v1.0.0"

  cluster_config_file = module.dev_cluster.config_file_path
  cluster_type        = module.dev_cluster.type
  app_namespace       = module.dev_cluster_namespaces.tools_namespace_name
  ingress_subdomain   = module.dev_cluster.ingress_hostname
  olm_namespace       = module.dev_software_olm.olm_namespace
  operator_namespace  = module.dev_software_olm.target_namespace
  name                = "argocd"
}
```

