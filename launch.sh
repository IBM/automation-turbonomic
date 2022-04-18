#!/usr/bin/env bash
ENV="credentials"

function prop {
    grep "${1}" ${ENV}.properties | grep -vE "^#" | cut -d'=' -f2 | sed 's/"//g'
}

if [[ -f "${ENV}.properties" ]]; then
    # Load the credentials
    GITOPS_REPO_USERNAME=$(prop "TF_VAR_gitops_repo_username")
    GITOPS_REPO_TOKEN=$(prop "TF_VAR_gitops_repo_token")
    CLUSTER_LOGIN_TOKEN=$(prop "TF_VAR_cluster_login_token")
    SERVER_URL=$(prop "TF_VAR_server_url")
else
    helpFunction "The ${ENV}.properties file is not found."
fi

echo $TF_VAR_cluster_login_token
docker run -it \
  -e "TF_VAR_gitops_repo_username=${GITOPS_REPO_USERNAME}" \
  -e "TF_VAR_gitops_repo_token=${GITOPS_REPO_TOKEN}" \
  -e "TF_VAR_cluster_login_token=${CLUSTER_LOGIN_TOKEN}" \
  -e "TF_VAR_server_url=${SERVER_URL}" \
  -v ${PWD}:/terraform \
  -w /terraform/workspace \
  quay.io/ibmgaragecloud/cli-tools:v1.1
