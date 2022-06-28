module "gitops_repo" {
  source = "github.com/cloud-native-toolkit/terraform-tools-gitops?ref=v1.19.4"

  branch = var.gitops_repo_branch
  gitea_host = var.gitops_repo_gitea_host
  gitea_org = var.gitops_repo_gitea_org
  gitea_token = var.gitops_repo_gitea_token
  gitea_username = var.gitops_repo_gitea_username
  gitops_namespace = var.gitops_repo_gitops_namespace
  host = var.gitops_repo_host
  org = var.gitops_repo_org
  project = var.gitops_repo_project
  public = var.gitops_repo_public
  repo = var.gitops_repo_repo
  sealed_secrets_cert = var.gitops_repo_sealed_secrets_cert
  server_name = var.gitops_repo_server_name
  strict = var.gitops_repo_strict
  token = var.gitops_repo_token
  type = var.gitops_repo_type
  username = var.gitops_repo_username
}
module "storage" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-ocp-storageclass?ref=v1.2.4"

  allow_expansion = var.storage_allow_expansion
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  isdefault = var.storage_isdefault
  name = var.storage_name
  parameter_list = var.storage_parameter_list == null ? null : jsondecode(var.storage_parameter_list)
  provisioner_name = var.storage_provisioner_name
  reclaim_policy = var.storage_reclaim_policy
  server_name = module.gitops_repo.server_name
  vol_binding_mode = var.storage_vol_binding_mode
}
module "turbo_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-namespace?ref=v1.11.2"

  argocd_namespace = var.turbo_namespace_argocd_namespace
  ci = var.turbo_namespace_ci
  create_operator_group = var.turbo_namespace_create_operator_group
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  name = var.turbo_namespace_name
  server_name = module.gitops_repo.server_name
}
