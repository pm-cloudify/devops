# IaC using Terraform

This is the project where I configured a simple server on ArvanCloud using terraform.

### What happens?

    1- creating a ssh key from panel
    2- create your 'terraform.tfvars' file
    3- create a sever using arvan cloud platform on terraform
    4- review plan and apply changes
    5- you can see server ip and ssh to it. (you should download and save ssh key provided)

### Helpful commands

```bash
terraform init
terraform validate
terraform plan -out=terraform.tfplan
terraform apply
```
