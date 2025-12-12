#!/bin/bash
set -e
REGION="ap-south-1"
CLUSTER="brain-tasks-eks"
NAMESPACE="default"
ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
IMAGE_URI="$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/brain-tasks-app:$1"

echo "Updating kubeconfig..."
aws eks update-kubeconfig --region $REGION --name $CLUSTER

kubectl -n $NAMESPACE set image deployment/brain-tasks-deployment brain-tasks-container=$IMAGE_URI --record

kubectl -n $NAMESPACE rollout status deployment/brain-tasks-deployment --timeout=120s
