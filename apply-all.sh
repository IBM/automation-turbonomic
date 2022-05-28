#!/usr/bin/env bash

find . -type d -maxdepth 1 | grep -vE "[.]/[.].*" | grep -vE "^[.]$" | grep -v workspace | sort | \
  while read dir;
do
  name=$(echo "$dir" | sed -E "s~[.]/(.*)~\1~g")

  if [[ "$name" = "160"* ]]; then
    echo "Please connect to your vpn instance using the .ovpn profile within the 110-ibm-fs-edge-vpc directory and press ENTER to proceed."
    read throwaway
  fi

  echo "*** Applying ${name} ***"

  cd "${name}" && \
    terraform init && \
    terraform apply -auto-approve && \
    cd - 1> /dev/null || \
    echo "*** Error applying ${name} ***" &&
    exit 1
done
