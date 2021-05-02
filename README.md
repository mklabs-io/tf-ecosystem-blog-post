# tf-ecosystem-blog-post

Companion repository for blog post about terraform 

## terraform

The terraform code in this repository is for demonstration purposes only, to easily show different 
aspects around tools that enhance terraform usage. They are located in `terraform/environments/base-example/`.

To run a terraform plan:
```bash
pushd terraform/environments/base-example/
# Run terraform plan
terraform init && terraform plan -out=plan.out
# if using aws-vault
aws-vault exec <your-profile> -- terraform init 
aws-vault exec <your-profile> -- terraform plan -out=plan.out
popd
```


## terraform compliance

Follow instructions to install [terraform-compliance](https://github.com/terraform-compliance/cli) [here](https://terraform-compliance.com/pages/installation/).
Terraform compliance test examples are located in `compliance/tf-compliance`.
To run them:
```bash
pushd terraform/environments/base-example/
# Run terraform plan
terraform init && terraform plan -out=plan.out
# if using aws-vault
aws-vault exec <your-profile> -- terraform init 
aws-vault exec <your-profile> -- terraform plan -out=plan.out
popd
# finally
terraform-compliance -f compliance/tf-compliance -p terraform/environments/base-example/plan.out
```