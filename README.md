# Terraform EC2 Web Server Setup
This repository contains Terraform code to spin up an EC2 instance, configure a web server, and automate the setup.
also contain gitlab.yml file for cicd automation.

# Prerequisites
1. AWS account with IAM credentials.
2. Terraform installed on your local machine.
3. GitLab account (for CI/CD workflow, optional).

# Web Server Setup
The user_data script in the Terraform code automates the installation and setup of the web server. When the EC2 instance is launched, the script runs automatically.
1. Updates the system packages.
2. Installs the Apache HTTP server (httpd).
3. Starts and enables the Apache service.
4. Creates a basic HTML page (Hello, World!) in the web server's root directory

# Monitoring and Logging (Optional)
To enable CloudWatch monitoring for the EC2 instance, Monitoring.tf file is added:
This will track CPU, memory, and other metrics for the EC2 instance.

# CI/CD Workflow (Optional)
This workflow:
  1. Initializes Terraform.
  2. Validates the Terraform configuration.
  3. Checks if the code is properly formatted.

# Steps to Execute the Code:
1. git clone https://github.com/your-repo/terraform-ec2.git
2. cd DevOps-Engineer-Candidate-Exercise
3. Initialize Terraform:
      terraform init
4. Validate the Terraform code:
      terraform validate
5. Apply the Terraform configuration:
      terraform apply
6. After the EC2 instance is created, access the web server using the public IP output:
      echo "http://$(terraform output -raw public_ip)"
7. Destroy the infrastructure when done:
     terraform destroy
