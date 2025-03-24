# Step 1: Define the provider (AWS)
provider "aws" {
  region = "ap-south-1" # Use your preferred region
}

# Step 2: Create a security group for the EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow HTTP and SSH traffic"

  # Allow inbound HTTP traffic (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound SSH traffic (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Step 3: Launch an EC2 instance
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0e35ddab05955cf57"
  instance_type          = "t2.micro"              # Free Tier
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Ensure the instance is launched in the default VPC and public subnet
  # subnet_id = data.aws_subnet.default.id

  # User data script to install and configure the web server
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apache2
              sudo systemctl enable --now apache2
              echo "<html><body><h1>Hello, World!</h1></body></html>" | sudo tee /var/www/html/index.html
              sudo chown www-data:www-data /var/www/html/index.html
              sudo chmod 644 /var/www/html/index.html
EOF


  # Add a tag to the instance for identification
  tags = {
    Name = "Terraform-EC2-Instance"
  }
}

# Step 4: Retrieve the default VPC and subnet information
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "cidr-block"
    values = ["172.31.16.0/20"]
  }
}

# Step 5: Output the public IP of the EC2 instance
output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
