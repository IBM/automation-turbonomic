#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

source "${SCRIPT_DIR}/validation-functions.sh"

if [[ -n "${BIN_DIR}" ]]; then
  export PATH="${BIN_DIR}:${PATH}"
fi

if [[ -z "${KUBECONFIG}" ]]; then
  echo "KUBECONFIG is not defined" >&2
  exit 1
fi

if ! command -v oc 1> /dev/null 2> /dev/null; then
  echo "oc cli not found" >&2
  exit 1
fi

if ! command -v kubectl 1> /dev/null 2> /dev/null; then
  echo "kubectl cli not found" >&2
  exit 1
fi

echo "*** Checking for Turbo resources ***"

TURBO_NS="turbonomic"
check_k8s_namespace "${TURBO_NS}"
#check_k8s_resource "${TURBO_NS}" deployment mongodb-kubernetes-operator
