#!/bin/bash

AWS_ACCOUNT_ID=303666750405
AWS_REGION=us-east-1
ECR_REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

VERSION=0.10.0

docker build --build-arg MINIWDL_VERSION=v${VERSION} -t aws/miniwdl-mirror:${VERSION} .
aws ecr create-repository --repository-name aws/miniwdl-mirror
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY
docker tag aws/miniwdl-mirror:${VERSION} ${ECR_REGISTRY}/aws/miniwdl-mirror:${VERSION}
docker push -a ${ECR_REGISTRY}/aws/miniwdl-mirror
