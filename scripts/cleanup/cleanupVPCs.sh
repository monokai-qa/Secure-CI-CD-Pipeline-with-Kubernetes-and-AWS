#!/bin/bash

# chmod +x scripts/cleanup/cleanupVPCs.sh && ./scripts/cleanup/cleanupVPCs.sh

#Remove all VPCs created previously
echo "Starting VPC cleanup..."

# Get a list of all VPC IDs
vpcs=$(aws ec2 describe-vpcs --query "Vpcs[*].VpcId" --output text)

if [ -z "$vpcs" ]; then
    echo "No VPCs found. Nothing to clean up!"
    exit 0
fi

for vpc in $vpcs; do
    echo "Processing VPC: $vpc"

    # 1. Delete subnets
    subnets=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpc" --query "Subnets[*].SubnetId" --output text)
    for subnet in $subnets; do
        echo "Deleting Subnet: $subnet"
        aws ec2 delete-subnet --subnet-id $subnet
    done

    # 2. Delete route tables (excluding the main route table)
    route_tables=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$vpc" --query "RouteTables[?Associations[0].Main==\`false\`].RouteTableId" --output text)
    for rt in $route_tables; do
        echo "Deleting Route Table: $rt"
        aws ec2 delete-route-table --route-table-id $rt
    done

    # 3. Delete security groups (excluding the default group)
    sg_ids=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$vpc" --query "SecurityGroups[?GroupName!='default'].GroupId" --output text)
    for sg in $sg_ids; do
        echo "Deleting Security Group: $sg"
        aws ec2 delete-security-group --group-id $sg
    done

    # 4. Delete internet gateways
    igws=$(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$vpc" --query "InternetGateways[*].InternetGatewayId" --output text)
    for igw in $igws; do
        echo "Detaching and deleting Internet Gateway: $igw"
        aws ec2 detach-internet-gateway --internet-gateway-id $igw --vpc-id $vpc
        aws ec2 delete-internet-gateway --internet-gateway-id $igw
    done

    # 5. Delete the VPC
    echo "Deleting VPC: $vpc"
    aws ec2 delete-vpc --vpc-id $vpc
done

echo "All VPCs have been cleaned up!"
