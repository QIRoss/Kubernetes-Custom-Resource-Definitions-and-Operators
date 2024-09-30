provider "aws" {
  region  = "us-east-1"
  profile = "qiross"
}

resource "aws_security_group" "k3s_sg" {
  name        = "k3s_security_group"
  description = "Allow K3s server-agent communication"

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "k3s_master" {
  ami           = "ami-0ee23bfc74a881de5"
  instance_type = "t2.micro"
  key_name      = "qiross"
  security_groups = [aws_security_group.k3s_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | sh -
              EOF

  tags = {
    Name = "k3s-master"
  }
}

resource "aws_instance" "k3s_agent" {
  ami           = "ami-0ee23bfc74a881de5"
  instance_type = "t2.micro"
  key_name      = "qiross"
  security_groups = [aws_security_group.k3s_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              K3S_URL=https://${aws_instance.k3s_master.private_ip}:6443 K3S_TOKEN=$(ssh -i ~/.ssh/qiross.pem ubuntu@${aws_instance.k3s_master.public_ip} 'sudo cat /var/lib/rancher/k3s/server/node-token') sh -s - agent
              EOF

  depends_on = [aws_instance.k3s_master]

  tags = {
    Name = "k3s-agent"
  }
}

output "master_public_ip" {
  value = aws_instance.k3s_master.public_ip
}

output "agent_public_ip" {
  value = aws_instance.k3s_agent.public_ip
}
