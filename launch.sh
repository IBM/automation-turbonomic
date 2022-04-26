#!/bin/bash

# IBM GSI Ecosystem Lab

SCRIPT_DIR="$(cd $(dirname $0); pwd -P)"
SRC_DIR="${SCRIPT_DIR}/automation"

if [[ ! -d "${SRC_DIR}" ]]; then
  SRC_DIR="${SCRIPT_DIR}"
fi

DOCKER_IMAGE="quay.io/cloudnativetoolkit/terraform:v1.1"

SUFFIX=$(echo $(basename ${SCRIPT_DIR}) | base64 | sed -E "s/[^a-zA-Z0-9_.-]//g" | sed -E "s/.*(.{5})/\1/g")
CONTAINER_NAME="cli-tools-${SUFFIX}"

echo "Cleaning up old container: ${CONTAINER_NAME}"

DOCKER_CMD="docker"
${DOCKER_CMD} kill ${CONTAINER_NAME} 1> /dev/null 2> /dev/null
${DOCKER_CMD} rm ${CONTAINER_NAME} 1> /dev/null 2> /dev/null

if [[ -n "$1" ]]; then
    echo "Pulling container image: ${DOCKER_IMAGE}"
    ${DOCKER_CMD} pull "${DOCKER_IMAGE}"
fi

ENV_FILE=""
if [[ -f "credentials.properties" ]]; then
  ENV_FILE="--env-file credentials.properties"
fi

echo "Initializing container ${CONTAINER_NAME} from ${DOCKER_IMAGE}"
${DOCKER_CMD} run -itd --name ${CONTAINER_NAME} \
   -v ${SRC_DIR}:/terraform \
   -v workspace:/workspaces \
   ${ENV_FILE} \
   -w /terraform \
   ${DOCKER_IMAGE}

echo "Attaching to running container..."
${DOCKER_CMD} attach ${CONTAINER_NAME}
