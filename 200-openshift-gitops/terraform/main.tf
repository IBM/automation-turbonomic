module "argocd-bootstrap" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd-bootstrap?ref=v1.12.0"

  bootstrap_path = module.gitops_repo.bootstrap_path
  bootstrap_prefix = var.argocd-bootstrap_bootstrap_prefix
  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  create_webhook = var.argocd-bootstrap_create_webhook
  git_token = module.gitops_repo.config_token
  git_username = module.gitops_repo.config_username
  gitops_repo_url = module.gitops_repo.config_repo_url
  ingress_subdomain = module.cluster.platform.ingress
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.target_namespace
  sealed_secret_cert = module.sealed-secret-cert.cert
  sealed_secret_private_key = module.sealed-secret-cert.private_key
}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login?ref=v1.3.1"

  ca_cert = var.cluster_ca_cert
  ca_cert_file = var.cluster_ca_cert_file
  cluster_version = var.cluster_cluster_version
  ingress_subdomain = var.cluster_ingress_subdomain
  login_password = var.cluster_login_password
  login_token = var.cluster_login_token
  login_user = var.cluster_login_user
  server_url = var.server_url
  skip = var.cluster_skip
  tls_secret_name = var.cluster_tls_secret_name
}
module "gitops_repo" {
  source = "github.com/cloud-native-toolkit/terraform-tools-gitops?ref=v1.19.1"

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
  sealed_secrets_cert = module.sealed-secret-cert.cert
  server_name = var.gitops_repo_server_name
  strict = var.gitops_repo_strict
  token = var.gitops_repo_token
  type = var.gitops_repo_type
  username = var.gitops_repo_username
}
module "gitops-cluster-config" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cluster-config?ref=v1.0.0"

  banner_background_color = var.gitops-cluster-config_banner_background_color
  banner_text = var.gitops-cluster-config_banner_text
  banner_text_color = var.gitops-cluster-config_banner_text_color
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  namespace = module.toolkit_namespace.name
  server_name = module.gitops_repo.server_name
}
module "gitops-console-link-job" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-console-link-job?ref=v1.4.6"

  cluster_ingress_hostname = var.gitops-console-link-job_cluster_ingress_hostname
  cluster_type = var.gitops-console-link-job_cluster_type
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  namespace = module.toolkit_namespace.name
  server_name = module.gitops_repo.server_name
  tls_secret_name = var.gitops-console-link-job_tls_secret_name
}
module "olm" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-olm?ref=v1.3.2"

  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  cluster_version = module.cluster.platform.version
}
module "sealed-secret-cert" {
  source = "github.com/cloud-native-toolkit/terraform-util-sealed-secret-cert?ref=v1.0.1"

  cert = var.sealed-secret-cert_cert
  cert_file = var.sealed-secret-cert_cert_file
  private_key = var.sealed-secret-cert_private_key
  private_key_file = var.sealed-secret-cert_private_key_file
}
module "toolkit_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-namespace?ref=v1.11.2"

  argocd_namespace = var.toolkit_namespace_argocd_namespace
  ci = var.toolkit_namespace_ci
  create_operator_group = var.toolkit_namespace_create_operator_group
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  name = var.toolkit_namespace_name
  server_name = module.gitops_repo.server_name
}
