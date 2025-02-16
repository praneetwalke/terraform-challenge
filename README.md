# Terraform AWS EC2 and RDS Deployment

## Overview
This Terraform configuration automates the provisioning of an AWS infrastructure that consists of:
- An EC2 instance running Apache Web Server.
- An RDS MySQL database instance.
- Security groups to control network access.

## Prerequisites
Before applying this Terraform configuration, ensure you have:
- An AWS account.
- Terraform installed on your local machine.
- An existing SSH key pair (`mykeypair.pem`).

## Resources Created
### EC2 Instance (Web Server)
- Runs Ubuntu Server 22.04 LTS (as Ubuntu 20.04 is no longer in the AWS Free Tier).
- Installs Apache2 web server.
- Opens ports for HTTP (80) and SSH (22).
- Outputs the public IP address of the instance.

### RDS MySQL Database
- Uses the `db.t3.micro` instance type (as `t2.micro` is no longer supported after December 31, 2024).
- Runs MySQL 5.7.
- Uses secure credentials managed via Terraform variables.
- Isolated with a dedicated security group.

### Security Groups
- `web_sg`: Allows SSH (22) and HTTP (80) traffic.
- `db_sg`: Restricts MySQL (3306) access to the web server only.

## Terraform Variables
| Variable Name  | Description | Default Value |
|---------------|-------------|--------------|
| `instance_type` | EC2 instance type | `t2.micro` |
| `ami_id` | Ubuntu 22.04 LTS AMI ID | `ami-0e1bed4f06a3b463d` |
| `key_name` | SSH key pair name | `mykeypair` |
| `db_username` | Database username | `admin` |
| `db_password` | Database password | (Sensitive)  |

## Outputs
| Output Name | Description |
|------------|-------------|
| `3.89.125.29` | Public IP of the web server |
| `terraform-mysql.c5m0y4mqi29a.us-east-1.rds.amazonaws.com:3306` | Endpoint of the RDS database |

![Screenshot (186)](https://github.com/user-attachments/assets/61533d33-1c4c-49f5-baf1-bea1b92b43d8)


## Usage
### 1. Initialize Terraform
```sh
terraform init
```

### 2. Validate Configuration
```sh
terraform validate
```

### 3. Apply the Configuration
```sh
terraform apply 
```

### 4. Access the Web Server
Once the infrastructure is deployed, you can access the web server by opening the public IP address in your browser:
```
http://3.89.125.29
```


![Screenshot (185)](https://github.com/user-attachments/assets/b6b24936-16f4-42be-8718-4b0c1cce6465)


### 5. Destroy the Infrastructure
To remove all AWS resources created by Terraform:
```sh
terraform destroy 
```

## Notes
- Ensure your AWS credentials are configured before running Terraform.
- Change the database password to a more secure value before deployment.
- The security group allows SSH access from any IP (`0.0.0.0/0`). Modify this in production environments for security.



