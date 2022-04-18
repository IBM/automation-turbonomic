#!/bin/bash
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


mkdir -p workspace
cd workspace

echo "Setting up workspace '${REF_ARCH}' template"
echo "*****"

cp "../terraform.tfvars.template" ./terraform.tfvars

ALL_ARCH="200|202|250"

find .. -type d -maxdepth 1 | grep -vE "[.][.]/[.].*" | grep -v workspace | sort | \
  while read dir;
do
  name=$(echo "$dir" | sed -E "s~[.][.]/(.*)~\1~g")

  if [[ ! -d "../${name}/terraform" ]]; then
    continue
  fi

  if [[ "${REF_ARCH}" == "all" ]] && [[ ! "${name}" =~ ${ALL_ARCH} ]]; then
    continue
  fi

  echo "Setting up workspace/${name} from ${name}"

  mkdir -p "${name}"
  cd "${name}"

  cp -R "../../${name}/terraform/"* .
  ln -s ../terraform.tfvars ./terraform.tfvars
  cd - > /dev/null
done
