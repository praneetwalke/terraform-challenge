variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu Server 22.04 LTS"
  default     = "ami-0e1bed4f06a3b463d"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "mykeypair"
}

variable "db_username" {
  description = "Database username"
  default     = "admin"
}

variable "db_password" {
  description = "Database password"
  sensitive   = true
  default = "admin!123"
}
