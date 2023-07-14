# Infra Demo

## AWS Infrastructure deployed with Terraform

Related [java backend demo](https://github.com/guschiriboga/java-demo) repository


### Pre-requisites

+ Github account
+ AWS account
+ CircleCI account
+ terraform
+ aws-cli

### Initial configuration

**GitHub account**
  + Clone / fork this repository to your own repository

**AWS account**
  + Create an user in AWS
    + Assign an access key pair with CLI access
  + Configure your CLI to connect with this user to your AWS account 

**CircleCI account**
  + Create a "Personal API Token" to use in the Terraform provider
  + Create a new file in the root of the project:
    + name: `circleci_data.json`
    + format:
  ```json
  {
    "api-key": "replace-with-your-own-api-key-value",
    "organization": "replace-with-your-own-organization-name"
  }
  ```
### Configure your AWS and repos info

In the file `terraform.tfvars`, change the following variables:
+ `project_name` used as a prefix for all resources
+ `region` set the AWS region to use
+ `cidr_info` set VPC, private and public subnets IP ranges
+ `repos_info` set your backend and infrastructure CircleCI names

### Deploy infrastructure

**Initialize terraform project**

`terraform init`

**Validate terraform code**

`terraform validate`

**Deploy resources**

`terraform apply`

**Destroy resources**

+ _It is recommended to delete the k8s deployment prior to destroy the infrastructure_

`terraform destroy`

## CI/CD configuration

In the file `circleci_config.yml` you can find the automated pipeline configuration file to deploy the infrastructure with CircleCI.

Take in account that the actual project doesn't manage a _terraform backend_ so you should won't have a state file to do a _destroy_ or a new _apply_.

This configuration is delivered only as an example.