#!/bin/bash

echo -e "\n\n******************   Script to Validate/Deploy/Destroy application on Azure platform   *********************\n\n"

# Pre-checks
source ~/.bash_profile

# Terraform Validation
function tf_validate()
{
    echo -e "Validating the Terraform configuration ... "
    terraform validate && echo "Validation passed !" || { echo -e "Validation failed, please see below error(s) :"; exit 1; }

    echo -e "Getting all required modules ... "
    terraform get && echo "Got necessary modules !" || { echo -e "Problem getting modules, please see below error(s) :"; exit 1; }
    echo "All checks passed !"
}

# Terraform Deployment
function tf_deploy()
{
    status=$?
    terraform plan && echo -e "Running Terraform Plan ..." || { echo -e "Problem running plan, please see below error(s) :"; exit 1; }
    read -p "Please review above plan and confirm. [y/n] :" response
    if [ "$response" = "y" ]; then
        echo -e "Proceeding ..."
    else
        echo -e "Exiting on user input !"; exit 1
    fi
    terraform apply -auto-approve
    echo -e "This failure is expected due to resource group unrecognition. See bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/49"
    echo -e "Attempting to apply once more ..."
    terraform apply -auto-approve || { echo -e "Problem running plan, please see below error(s) :"; exit 1; }
    # if [ $status -ne 0 ]; then
    #     echo -e "This failure is expected due to resource group unrecognition. See bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/49\n"
    #     echo -e "Attempting to apply once more ...\n"
    #     terraform apply -auto-approve
    #     if [ $status -eq 0 ]; then
    #         continue
    #     else
    #         break
    #     fi
    # fi
}

# Terraform Destruction
function tf_destroy()
{
    status=$?
    echo -e "About to destory all resources ..."
    terraform destroy || { echo -e "Unable to destory ... Trying again :"; terraform destroy -force; }
    # while [ $status -ne 0 ]; do
    #     echo -e "Terraform destroy failed. Running again ..."
    #     terraform destroy -force
    # done
}

# Usage function
usage()
{
    echo "Usage: $0 -v -c -d -h"
    echo "  where"
    echo "    -v: validates terraform configuration and makes the env ready"
    echo "    -c: creates and deploys the resources"
    echo "    -d: destroys all resources"
    echo "    -h: shows usage message"
}

# Main program
if [ $# -eq 0 ]; then
  usage
  exit 1
fi

while getopts vcdh opt
do
  case "$opt" in
    v) tf_validate;;
    c) tf_validate && tf_deploy;;
    d) tf_destroy;;
    h) usage;;
  esac
done
