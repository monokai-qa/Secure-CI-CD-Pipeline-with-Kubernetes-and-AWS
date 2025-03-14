#!/bin/bash

# chmod +x scripts/cleanup/cleanupIAMRoles.sh && ./scripts/cleanup/cleanupIAMRoles.sh

#!/bin/bash

echo "Starting IAM role cleanup..."

# Get a list of all IAM roles
roles=$(aws iam list-roles --query "Roles[*].RoleName" --output text)

if [ -z "$roles" ]; then
    echo "No IAM roles found. Nothing to clean up!"
    exit 0
fi

for role in $roles; do
    # Skip AWS service-linked roles
    if [[ "$role" == *"AWSServiceRoleFor"* ]]; then
        echo "Skipping AWS service-linked role: $role"
        continue
    fi

    echo "Processing IAM role: $role"

    # 1. Detach all managed policies
    policies=$(aws iam list-attached-role-policies --role-name $role --query "AttachedPolicies[*].PolicyArn" --output text)
    for policy in $policies; do
        echo "Detaching policy: $policy from role: $role"
        aws iam detach-role-policy --role-name $role --policy-arn $policy
    done

    # 2. Delete inline policies
    inline_policies=$(aws iam list-role-policies --role-name $role --query "PolicyNames" --output text)
    for inline_policy in $inline_policies; do
        echo "Deleting inline policy: $inline_policy from role: $role"
        aws iam delete-role-policy --role-name $role --policy-name $inline_policy
    done

    # 3. Delete the IAM role
    echo "Deleting IAM role: $role"
    aws iam delete-role --role-name $role
done

echo "All IAM roles have been cleaned up!"
