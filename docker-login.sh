# Push to registry if configured
if [ ! -z "${DOCKER_REGISTRY}" ]; then
    docker login --username=${DOCKER_USER} --password=${DOCKER_PASS} --email=${DOCKER_EMAIL} ${DOCKER_REGISTRY}
fi
