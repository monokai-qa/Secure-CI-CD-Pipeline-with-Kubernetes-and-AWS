#!/bin/bash

# chmod +x phase2.sh && ./phase2.sh

echo "Starting Phase 2..."

cd app

# Step 1: Wait for the EKS Cluster to be available
echo "Waiting for EKS Cluster to be available..."
aws eks --region eu-north-1 wait cluster-active --name eks-cluster

# Step 2: Update kubeconfig to use the newly created EKS cluster
echo "Updating kubeconfig..."
aws eks --region eu-north-1 update-kubeconfig --name eks-cluster

# Step 3: Verify kubectl configuration
echo "Verifying kubectl configuration..."
kubectl get svc

# Step 4: Deploy Flask app (Assuming flask-deployment.yaml is in the current directory)
echo "Deploying Flask app..."
kubectl apply -f flask-deployment.yaml

# Step 5: Wait for Pods to be running
echo "Waiting for Flask app Pods to be running..."
kubectl rollout status deployment flask-app-deployment

# Step 6: Get External IP of the Service
echo "Fetching Flask app service external IP..."
SERVICE_IP=$(kubectl get svc flask-app-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "Flask app is available at: http://$SERVICE_IP"

echo "Phase 2 completed successfully!"


# Create docker image
#docker build -t python-flask:v1 .
#docker images

# Create the Deployment and Service
#kubectl apply -f flask-deployment.yaml
#kubectl get deployment
#kubectl get pods
#kubectl get svc
