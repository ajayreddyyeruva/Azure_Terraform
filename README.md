# Azure-Terraform

Deploying resources to Azure Cloud portal made easy with Terraform.

## Getting Started

This Terraform code will deploy a complete stack including Network, Loadbalancer, Nginx, App servers, DB servers and a Bastion server. The deployment will get you a look and feel of Terraform for Azure.

### Prerequisites

* Get [Azure Pay-As-You-Go subscription](https://azure.microsoft.com/en-in/free/free-account-faq/) (free trial).
* Get [Terraform](https://www.terraform.io/downloads.html) depending on your OS.
* Modify the provider.tf file in root module with your subscription_id, client_id, client_secret and tenant_id.

## Usage

```
$ ./terraform_azure.sh -h


******************   Script to Validate/Deploy/Destroy application on Azure platform   *********************


Usage: ./terraform_azure.sh -v -c -d -h
  where
    -v: validates terraform configuration and makes the env ready
    -c: creates and deploys the resources
    -d: destroys all resources
    -h: shows usage message

```
Note: A Linux Bastion server would also be deployed as part of this configuration. Only this machine will have Public access and will be the gateway to your environment.

P.S: This is the initial push. Code changes and modifications are expected !

Hope you like it ... :)
