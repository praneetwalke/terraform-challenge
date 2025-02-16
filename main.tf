resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web_sg.name]
  key_name        = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<h1>Welcome to Terraform Web Server</h1>" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = "TerraformWebServer"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Allow MySQL access from web server"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "mysql" {
  identifier             = "terraform-mysql"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  storage_type           = "gp2"
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
}

