#!/bin/bash

# chmod +x scripts/phase1.sh && ./scripts/phase1.sh

cd terraform

echo "Initializing Terraform..."
terraform init

echo "Validating Terraform configuration..."
terraform validate
if [ $? -ne 0 ]; then
    echo "Terraform validation failed!"
    exit 1
fi

echo "Generating Terraform plan..."
terraform plan
if [ $? -ne 0 ]; then
    echo "Terraform plan failed!"
    exit 1
fi

echo "Applying Terraform configuration..."
terraform apply -auto-approve
if [ $? -ne 0 ]; then
    echo "Terraform apply failed!"
    exit 1
fi

echo "Terraform apply completed successfully!"
