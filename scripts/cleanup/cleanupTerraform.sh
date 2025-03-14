#!/bin/bash

# chmod +x scripts/cleanup/cleanupTerraform.sh && ./scripts/cleanup/cleanupTerraform.sh

# Remove all generated Terraform files
cd terraform

rm .terraform.lock.hcl
rm terraform.tfstate
rm .terraform.tfstate.lock.info
rm terraform.tfstate.backup
rm -r .terraform/*
rmdir .terraform

cd ..
