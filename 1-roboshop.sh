#!/bin/bash
AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-01fb8f67c6dc9cd19"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping"  "payment" "dispatch" "frontend")

for instance in "{$INSTANCES[@]}"
do
  INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-groups sg-01fb8f67c6dc9cd19 --output text) 
    if [ $instance != "frontend" ]
     then
      IP=$(aws ec2 describe-instances $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
       IP=$(aws ec2 describe-instances $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
    fi
    echo "$instance ip address: $IP"
done
    

