#!/bin/bash
set -e

REGION="ap-south-1"
CLUSTER="brain-tasks-eks"
NAMESPACE="default"

aws eks update-kubeconfig --region $REGION --name $CLUSTER

IMAGE_TAG=$(cat imageTag.txt)
IMAGE="aravindkumar18/brain-tasks-app:$IMAGE_TAG"

kubectl set image deployment/brain-tasks-deployment \
brain-tasks-container=$IMAGE \
-n $NAMESPACE

kubectl rollout status deployment/brain-tasks-deployment -n $NAMESPACE
