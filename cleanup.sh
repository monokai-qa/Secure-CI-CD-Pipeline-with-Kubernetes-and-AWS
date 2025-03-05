#!/bin/bash

# chmod +x cleanup.sh && ./cleanup.sh

# Re-initialize the Terraform backend before destroying resources
terraform init -reconfigure

echo "Destroying EKS cluster and all Terraform-managed resources..."
terraform destroy -auto-approve
if [ $? -ne 0 ]; then
    echo "Terraform destroy failed!"
    exit 1
fi

echo "All done! Your infrastructure is up and running!"
