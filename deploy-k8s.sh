#!/bin/bash
set -e

# -------- CONFIG --------
REGION="ap-south-1"
CLUSTER_NAME="brain-tasks-eks"
NAMESPACE="default"

# Docker Hub image (CHANGE USERNAME)
DOCKERHUB_USERNAME="maravind8981lab"
IMAGE_NAME="brain-tasks-app"

# Image tag passed from CodeBuild
IMAGE_TAG=${IMAGE_TAG:-latest}

FULL_IMAGE="$DOCKERHUB_USERNAME/$IMAGE_NAME:$IMAGE_TAG"

echo "-----------------------------------"
echo "Deploying image: $FULL_IMAGE"
echo "Cluster: $CLUSTER_NAME"
echo "Namespace: $NAMESPACE"
echo "-----------------------------------"

# -------- Update kubeconfig --------
echo "Updating kubeconfig..."
aws eks update-kubeconfig \
  --region $REGION \
  --name $CLUSTER_NAME

# -------- Deploy to Kubernetes --------
echo "Updating deployment image..."
kubectl set image deployment/brain-tasks-deployment \
  brain-tasks-container=$FULL_IMAGE \
  -n $NAMESPACE

# -------- Verify rollout --------
echo "Waiting for rollout to complete..."
kubectl rollout status deployment/brain-tasks-deployment \
  -n $NAMESPACE \
  --timeout=300s

echo "✅ Deployment successful"
