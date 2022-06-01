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
   echo "  -h     Print this help"
   echo
}

CLOUD_PROVIDER=""
PREFIX_NAME=""

# Get the options
while getopts ":p:n:h:" option; do
   case $option in
      h) # display Help
         Usage
         exit 1;;
      p)
         CLOUD_PROVIDER=$OPTARG;;
      n) # Enter a name
         PREFIX_NAME=$OPTARG;;
     \?) # Invalid option
         echo "Error: Invalid option"
         Usage
         exit 1;;
   esac
done

echo $CLOUD_PROVIDER
echo $PREFIX_NAME

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

if [[ -d "${WORKSPACE_DIR}" ]]; then
  DATE=$(date "+%Y%m%d%H%M")
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
elif [[ "${CLOUD_PROVIDER}" == "ibm" ]] || [[ "${CLOUD_PROVIDER}" == "ibmcloud" ]]; then
  RWO_STORAGE="ibmc-vpc-block-mzr"
else
  RWO_STORAGE="<your block storage on aws: gp2, on azure: managed-premium, on ibm: ibmc-vpc-block-mzr>"
fi

cat "${SCRIPT_DIR}/terraform.tfvars.template" | \
  sed "s/PREFIX/${PREFIX_NAME}/g" | \
  sed "s/RWO_STORAGE/${RWO_STORAGE}/g" \
  > "${SCRIPT_DIR}/terraform.tfvars"

ln -s "${SCRIPT_DIR}/terraform.tfvars" ./terraform.tfvars

cp "${SCRIPT_DIR}/apply-all.sh" "${WORKSPACE_DIR}/apply-all.sh"
cp "${SCRIPT_DIR}/destroy-all.sh" "${WORKSPACE_DIR}/destroy-all.sh"

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

  if [[ -n "${RWO_STORAGE}" ]] && [[ -n "${CLOUD_PROVIDER}" ]]; then
    BOM_STORAGE=$(grep -E "^ +storage" "${SCRIPT_DIR}/${name}/bom.yaml" | sed -E "s~[^:]+: [\"']?(.*)[\"']?~\1~g")
    BOM_PLATFORM=$(grep -E "^ +platform" "${SCRIPT_DIR}/${name}/bom.yaml" | sed -E "s~[^:]+: [\"']?(.*)[\"']?~\1~g")

    if [[ -n "${BOM_PLATFORM}" ]] && [[ "${BOM_PLATFORM}" != "${CLOUD_PROVIDER}" ]]; then
      echo "  Skipping ${name} because it does't match ${CLOUD_PLATFORM}"
      continue
    fi

  fi

  echo "Setting up current/${name} from ${name}"

  mkdir -p ${name}
  cd "${name}"

  cp -R "${SCRIPT_DIR}/${name}/terraform/"* .
  ln -s "${WORKSPACE_DIR}"/terraform.tfvars ./terraform.tfvars

  cd - > /dev/null
done

echo "move to ${WORKSPACE_DIR} this is where your automation is configured"
