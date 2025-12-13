#!/bin/bash
set -e

REGION="ap-south-1"
CLUSTER="brain-tasks-eks"
NAMESPACE="default"

DOCKERHUB_USERNAME="aravindkumar18"
IMAGE_NAME="brain-tasks-app"

IMAGE_TAG=$(cat imageTag.txt)
FULL_IMAGE="$DOCKERHUB_USERNAME/$IMAGE_NAME:$IMAGE_TAG"

echo "Deploying image: $FULL_IMAGE"

aws eks update-kubeconfig --region $REGION --name $CLUSTER

kubectl set image deployment/brain-tasks-deployment \
  brain-tasks-container=$FULL_IMAGE \
  -n $NAMESPACE

kubectl rollout status deployment/brain-tasks-deployment \
  -n $NAMESPACE --timeout=300s

echo "✅ Deployment successful"
