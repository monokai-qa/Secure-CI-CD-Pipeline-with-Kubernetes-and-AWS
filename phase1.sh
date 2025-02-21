#!/bin/bash

# chmod +x phase1.sh && ./phase1.sh

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

# Re-initialize the Terraform backend before destroying resources
terraform init -reconfigure

echo "Destroying EKS cluster and all Terraform-managed resources..."
terraform destroy -auto-approve
if [ $? -ne 0 ]; then
    echo "Terraform destroy failed!"
    exit 1
fi

echo "All done! Your infrastructure is up and running!"
