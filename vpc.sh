#!/bin/bash

# Script to create a VPC with CIDR block 10.0.0.0/26 using AWS CLI

VPC_CIDR="10.0.0.0/26"

echo "Creating VPC with CIDR $VPC_CIDR..."

VPC_ID=$(aws ec2 create-vpc --cidr-block $VPC_CIDR --output text --query 'Vpc.VpcId')

if [ -z "$VPC_ID" ]; then
  echo "Failed to create VPC."
  exit 1
fi

echo "VPC created with ID: $VPC_ID"

# Enable DNS support and DNS hostnames (recommended)
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-support "{\"Value\":true}"
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames "{\"Value\":true}"

echo "DNS support and hostnames enabled for VPC $VPC_ID"