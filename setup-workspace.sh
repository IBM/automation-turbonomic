#!/bin/bash

# IBM GSI Ecosystem Lab

Usage()
{
   echo "Creates a workspace folder and populates it with automation bundles you require."
   echo
   echo "Usage: setup-workspace.sh"
   echo "  options:"
   echo "  -p     Cloud provider (aws, azure, ibm)"
   echo "  -n     (optional) prefix that should be used for all variables"
   echo "  -g     (optional) the git host that will be used for the gitops repo. If left blank gitea will be used by default. (Github, Github Enterprise, Gitlab, Bitbucket, Azure DevOps, and Gitea servers are supported)"
   echo "  -a     Adds the configuration to the existing workspace"
   echo "  -h     Print this help"
   echo
}

CLOUD_PROVIDER=""
PREFIX_NAME=""
APPEND=""
GIT_HOST=""
STORAGE=""

# Get the options
while getopts ":p:n:a:g:s:h:" option; do
   case $option in
      h) # display Help
         Usage
         exit 1;;
      a)
         APPEND="true";;
      p)
         CLOUD_PROVIDER=$OPTARG;;
      n) # Enter a name
         PREFIX_NAME=$OPTARG;;
      g) # Enter a name
         GIT_HOST=$OPTARG;;
      s) # Enter a name
         STORAGE=$OPTARG;;
     \?) # Invalid option
         echo "Error: Invalid option"
         Usage
         exit 1;;
   esac
done

if [ -z "${CLOUD_PROVIDER}" ] || [ -z "${PREFIX_NAME}" ]; then
    Usage
    exit 1;
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
WORKSPACES_DIR="${SCRIPT_DIR}/../workspaces"
WORKSPACE_DIR="${WORKSPACES_DIR}/current"

if [[ -n "${PREFIX_NAME}" ]]; then
  PREFIX_NAME="${PREFIX_NAME}-"
fi


ARG_ARRAY=( "$@" )

if [[ " ${ARG_ARRAY[*]} " =~ " -a " ]]; then
  APPEND="true"
fi


if [[ -d "${WORKSPACE_DIR}" ]] && [[ "${APPEND}" != "true" ]]; then
  DATE=$(date "+%Y%m%d%H%M")
  echo "  Saving current workspaces directory to workspace-${DATE}"
  mv "${WORKSPACE_DIR}" "${WORKSPACES_DIR}/workspace-${DATE}"

  cp "${SCRIPT_DIR}/terraform.tfvars" "${WORKSPACES_DIR}/workspace-${DATE}/terraform.tfvars"
fi

mkdir -p "${WORKSPACE_DIR}"
cd "${WORKSPACE_DIR}"

echo "Setting up workspace in '${WORKSPACE_DIR}'"
echo "*****"

if [[ "${CLOUD_PROVIDER}" == "aws" ]]; then
  RWO_STORAGE="gp2"
elif [[ "${CLOUD_PROVIDER}" == "azure" ]]; then
  RWO_STORAGE="managed-premium"
elif [[ "${CLOUD_PROVIDER}" == "ibm" ]] ; then
  RWO_STORAGE="ibmc-vpc-block-metro-10iops-tier"
else
  RWO_STORAGE="<your block storage on aws: gp2, on azure: managed-premium, on ibm: ibmc-vpc-block-metro-10iops-tier>"
fi

if [[ -z "${GIT_HOST}" ]]; then
  GITHOST_COMMENT="#"
fi

cat "${SCRIPT_DIR}/terraform.tfvars.template-turbonomic" | \
  sed "s/PREFIX/${PREFIX_NAME}/g" | \
  sed "s/RWO_STORAGE/${RWO_STORAGE}/g" \
  > "${WORKSPACE_DIR}/turbonomic.tfvars"

if [[ ! -f "${WORKSPACE_DIR}/gitops.tfvars" ]]; then
  cat "${SCRIPT_DIR}/terraform.tfvars.template-gitops" | \
    sed -E "s/#(.*=\"GIT_HOST\")/${GITHOST_COMMENT}\1/g" | \
    sed "s/PREFIX/${PREFIX_NAME}/g"  | \
    sed "s/GIT_HOST/${GIT_HOST}/g" \
    > "${WORKSPACE_DIR}/gitops.tfvars"
fi

cp "${SCRIPT_DIR}/apply-all.sh" "${WORKSPACE_DIR}"
cp "${SCRIPT_DIR}/destroy-all.sh" "${WORKSPACE_DIR}"
cp "${SCRIPT_DIR}/plan-all.sh" "${WORKSPACE_DIR}"
cp -R "${SCRIPT_DIR}/.mocks" "${WORKSPACE_DIR}"
cp "${SCRIPT_DIR}/layers.yaml" "${WORKSPACE_DIR}"
cp "${SCRIPT_DIR}/terragrunt.hcl" "${WORKSPACE_DIR}"
mkdir -p "${WORKSPACE_DIR}/bin"

WORKSPACE_DIR=$(cd "${WORKSPACE_DIR}"; pwd -P)

echo "Setting up automation  ${WORKSPACE_DIR}"

echo ${SCRIPT_DIR}

find ${SCRIPT_DIR}/. -maxdepth 1 -type d | grep -vE "[.][.]/[.].*" | grep -v workspace | sort | \
  while read dir;
do

  name=$(echo "$dir" | sed -E "s/.*\///")

  if [[ ! -f "${SCRIPT_DIR}/${name}/main.tf" ]]; then
    continue
  fi

  # TODO ideally this should match an attribute in the BOM instead of hard coding the name
  if [[ "${name}" == "105-existing-openshift" ]] && [[ $(find "${WORKSPACE_DIR}" -maxdepth 1 -name "105-*" | wc -l) -gt 0 ]]; then
    continue
  fi

  if [[ -n "${RWO_STORAGE}" ]] && [[ -n "${CLOUD_PROVIDER}" ]]; then
    BOM_STORAGE=$(grep -E "^ +storage" "${SCRIPT_DIR}/${name}/bom.yaml" | sed -E "s~[^:]+: [\"']?(.*)[\"']?~\1~g")
    BOM_PLATFORM=$(grep -E "^ +platform" "${SCRIPT_DIR}/${name}/bom.yaml" | sed -E "s~[^:]+: [\"']?(.*)[\"']?~\1~g")

    if [[ -n "${BOM_PLATFORM}" ]] && [[ "${BOM_PLATFORM}" != "${CLOUD_PROVIDER}" ]]; then
      echo "  Skipping ${name} because it doesn't match ${CLOUD_PLATFORM}"
      continue
    fi

  fi

  echo "Setting up current/${name} from ${name}"

  mkdir -p ${name}
  cd "${name}"

  cp -R -L "${SCRIPT_DIR}/${name}/"* .

  ln -s ../bin bin2

  cd - > /dev/null
done

echo "move to ${WORKSPACE_DIR} this is where your automation is configured"
