#!/bin/bash
set -e

REGION="ap-south-1"
CLUSTER_NAME="brain-tasks-eks"
NAMESPACE="default"

echo "Updating kubeconfig..."
aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME

echo "Loading image tag..."
source image.env

echo "Deploying image: aravindkumar18/brain-tasks-app:$IMAGE_TAG"

kubectl set image deployment/brain-tasks-deployment \
brain-tasks-container=aravindkumar18/brain-tasks-app:$IMAGE_TAG \
-n $NAMESPACE

echo "Waiting for rollout..."
kubectl rollout status deployment/brain-tasks-deployment -n $NAMESPACE
