variable "security_group_name" {
  type = string
  description = "Name of the security group"
  default = "goviolin-security-group"
}

resource "aws_security_group" "goviolin-security" {
  name = var.security_group_name
  vpc_id = module.vpc.vpc_id

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  //To access jenkins
  ingress {
    from_port = 8080  //for jenkins
    protocol = "tcp"
    to_port = 8080    //for jenkins
    cidr_blocks = ["0.0.0.0/0" ]
  }
    //To access https
  ingress {
    from_port = 443  //for https
    protocol = "tcp"
    to_port = 443    //for https
     cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1" // all protocols
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}