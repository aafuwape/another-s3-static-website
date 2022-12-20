## Create a static website on S3 using terraform

### Testing
To test this website deployment, you will need the following.

- A free-tier eligible AWS Account.
- An IAM user with permissions to create the elements of this architecture.
- add the access keys of the IAM to your environment variables using the commands below.
- Terraform installed on your computer 

### Commands
### Add access keys to access the AWS environment
```
export AWS_ACCESS_KEY_ID="ACCESS KEY ID"
export AWS_SECRET_ACCESS_KEY="SECRET KEY"
```

### Testing the terraform template
- clone the repo
- cd into the folder
- terraform init
- terraform plan -out website.tfplan
- terraform apply "website.tfplan"
- the link to the website will be presented as an output
- curl -I http://link-to-website
- if Content-Type: text/html, you should be able to opening it in firefox

### When you are done evaluating the website, you can remove it from your AWS account using 
```
terraform destroy -auto-approve  
```

### Challenges faced

**Problem 1**

main.using_policy_json

This required hardcoding he bucket arn.

**solution**  
Moved the policy into the main.tf file and made it a variable.

**Problem 2**

Static website working, but index file is being downloaded instead of displayed.


**solution**  
Problem with the content type
This seems to be a bug.

Added  content_type = "text/html" to the uploaded objects

It only displays on Firefox
