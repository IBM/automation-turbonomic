#!/bin/bash

# IBM GSI Ecosystem Lab

Usage()
{
   echo "Creates a workspace folder and populates it with automation bundles you require."
   echo
   echo "Usage: setup-workspace.sh"
   echo "  options:"
   echo "  -h     Print this help"
   echo
}

# Get the options
while getopts ":h:" option; do
   case $option in
      h) # display Help
         Usage
         exit 1;;
     \?) # Invalid option
         echo "Error: Invalid option"
         Usage
         exit 1;;
   esac
done

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
WORKSPACES_DIR="${SCRIPT_DIR}/../workspaces"
WORKSPACE_DIR="${WORKSPACES_DIR}/current"

if [[ -d "${WORKSPACE_DIR}" ]]; then
  DATE=$(date "+%Y%m%d%H%M")
  mv "${WORKSPACE_DIR}" "${WORKSPACES_DIR}/workspace-${DATE}"
fi

mkdir -p "${WORKSPACE_DIR}"
cd "${WORKSPACE_DIR}"

echo "Setting up workspace in '${WORKSPACE_DIR}'"
echo "*****"


cp "${SCRIPT_DIR}/terraform.tfvars.template" "${SCRIPT_DIR}/terraform.tfvars"
ln -s "${SCRIPT_DIR}/terraform.tfvars" ./terraform.tfvars

echo "Setting up workspace from '${TEMPLATE_FLAVOR}' template"
echo "*****"

WORKSPACE_DIR=$(cd "${WORKSPACE_DIR}"; pwd -P)

ALL_ARCH="200|202|250"

echo "Setting up automation  ${WORKSPACE_DIR}"

echo ${SCRIPT_DIR}

find ${SCRIPT_DIR}/. -type d -maxdepth 1 | grep -vE "[.][.]/[.].*" | grep -v workspace | sort | \
  while read dir;
do

  name=$(echo "$dir" | sed -E "s/.*\///")

  if [[ ! -d "${SCRIPT_DIR}/${name}/terraform" ]]; then
    continue
  fi

  if [[ "${REF_ARCH}" == "all" ]] && [[ ! "${name}" =~ ${ALL_ARCH} ]]; then
    continue
  fi

  echo "Setting up current/${name} from ${name}"

  mkdir -p ${name}
  cd "${name}"

  cp -R "${SCRIPT_DIR}/${name}/terraform/"* .
  ln -s "${WORKSPACE_DIR}"/terraform.tfvars ./terraform.tfvars

  cd - > /dev/null
done

echo "move to ${WORKSPACE_DIR} this is where your automation is configured"
