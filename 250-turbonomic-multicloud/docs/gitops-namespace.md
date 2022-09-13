# Namespace gitops config

Module to configure a GitOps repo to provision a namespace


## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform >= v0.15
- git

### Terraform providers

- None

## Module dependencies

This module makes use of the output from other modules:

- GitOps repo - github.com/cloud-native-toolkit/terraform-tools-gitops.git

## Example usage

```hcl-terraform
module "gitops_namespace" {
  source = "github.com/ibm-garage-cloud/terraform-gitops-namespace.git"

  config_repo = module.gitops.config_repo
  config_token = module.gitops.config_token
  config_paths = module.gitops.config_paths
  application_repo = module.gitops.application_repo
  application_token = module.gitops.application_token
  application_paths = module.gitops.application_paths
  name = var.namespace
  create_operator_group = false
}
```

