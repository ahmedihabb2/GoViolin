variable "ec2_instance_type" {
  type = string
  description = "EC2 instance type"
  default = "t2.micro"
}
variable "ec2_ami_id" {
  type = string
  description = "EC2 AMI ID"
  default = "ami-0b9c9f2b"
}
  
variable "ec2_key_name" {
  type = string
  description = "EC2 key name"
  default = "goviolin"
}
  

resource "aws_instance" "goviloin-iac" {
  ami = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.goviolin-security.id]
  subnet_id = module.vpc.public_subnets
  associate_public_ip_address = true
  key_name = var.ec2_key_name
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }

  depends_on =  [aws_security_group.goviolin-security.id]
}