#!/bin/bash

# chmod +x scripts/cleanupBeginning.sh && ./scripts/cleanupBeginning.sh

#Remove all Terraform created previously
chmod +x scripts/cleanup/cleanupTerraform.sh && ./scripts/cleanup/cleanupTerraform.sh

#Remove all VPCs created previously
chmod +x scripts/cleanup/cleanupVPCs.sh && ./scripts/cleanup/cleanupVPCs.sh

#Remove all IAM Roles created previously
chmod +x scripts/cleanup/cleanupIAMRoles.sh && ./scripts/cleanup/cleanupIAMRoles.sh
