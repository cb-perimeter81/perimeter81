# Corey Brothers - Perimeter81 Take Home

To see running live naviagte or curl this address
```
https://k8s-default-ingressn-e31df353d5-e4043216417350f6.elb.us-east-2.amazonaws.com
```

## app

To run, test, and build the python app see (here)[./app/README.md]

## charts

### app

A helm chart is included to deploy the app under `modules/app/charts/app`,
normally this would be published to ecr but is instead of included in the module
for simplicity in this exercise.

## terraform module

### eks

This module will set up a simple EKS cluster with its own VPC, to access the cluster once deployed
use the aws cli, any user in the account should be able to switch to the role for simplicity.
```
aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME --role-arn $ADMIN_ROLE_ARN --alias $EKS_CLUSTER_NAME
```
Where `$EKS_CLUSTER_NAME` is the output `cluster_name` and `$ADMIN_ROLE_ARN` is the output `cluster_admin_iam_role_arn`

### app

This module will deploy the simple app through helm to the EKS cluster

## deployment

To deploy, in the `deployment` directory run
```
terragrunt run-all apply
```
