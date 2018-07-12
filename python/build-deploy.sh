#!/bin/sh

export IMAGE_NAME='python-test'
export VERSION_NAME='1.0'
export REGISTRY='http://192.168.99.100:32525'

docker build -t ${IMAGE_NAME}:${VERSION_NAME} .
docker tag ${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}:${VERSION_NAME}
#docker push ${REGISTRY}/${IMAGE_NAME}:${VERSION_NAME}
