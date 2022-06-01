# Console Link Cronjob module

Module that populates  gitops repository with the Console Link Cronjob chart from https://charts.cloudnativetoolkit.dev. The chart deploys a cron job into a cluster that runs periodically (every 5 minutes by default) looking for matching resources and creating cron jobs and config maps with the information. The matching resources include routes with the `console-link.cloud-native-toolkit.dev/enabled=true` label and `logdna-agent` and `sysdig-agent` daemonsets.

This module uses the following Helm Charts from toolkit-charts( https://charts.cloudnativetoolkit.dev ) : https://github.com/cloud-native-toolkit/toolkit-charts/blob/main/stable/console-link-cronjob/README.md

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform >= v0.15

### Terraform providers

- None

## Module dependencies

This module makes use of the output from other modules:

- GitOps - github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - github.com/cloud-native-toolkit/terraform-gitops-namespace.git.git

## Example usage

```hcl-terraform
module "console_link_job" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-console-link-job.git"

  config_repo = module.gitops.config_repo
  config_token = module.gitops.config_token
  config_paths = module.gitops.config_paths
  config_projects = module.gitops.config_projects
  application_repo = module.gitops.application_repo
  application_token = module.gitops.application_token
  application_paths = module.gitops.application_paths
}
```

