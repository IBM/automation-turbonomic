# GitOps repo module

Module that prepares a GitOps repo for use with ArgoCD. If the `provision` flag is `true` then a new git repo will be provisioned. If not, the provided repo name is expected to already exist.

After cloning the git repo, an initial directory structure is set up along with bootstrap configuration to perform the initial setup of ArgoCD.

## Supported git servers

The module supports creating a repository in one of six different git servers:

- GitHub
- GitHub Enterprise
- Gitlab
- Bitbucket
- Gitea
- Azure DevOps

The selection of the git server type is determined by the value provided for the `host`.

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
  source = "github.com/cloud-native-toolkit/terraform-tools-gitops"

  host = var.git_host
  org  = var.git_org
  repo = var.git_repo
  username = var.git_username
  token = var.git_token
  project = var.git_project
  gitops_namespace = var.gitops_namespace
  sealed_secrets_cert = module.cert.cert
  strict = var.gitops_strict
}
```

