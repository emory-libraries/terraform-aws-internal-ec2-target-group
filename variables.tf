variable "alb_listener_arn" {
    description = "The listener arn of the ALB this EC2's target group will be attached to. aws_alb_listener.alb_listener.arn"
}

variable "application_fqdn" {
  type = string
  description = <<EOF
    The fully qualified production domain name. This is name is used only by the application load balancer, not route53.
    Note that the template will also create another domain name for streaming that is streaming.{application_fqdn}.
    EOF
}

variable "application_fqdn_workspace_insertion_index" {
  type = number
  default = 0
  description = <<EOF
    The application fqdn is split into a list at each '.', this variable is the index (first object is 0) where the workspace will be appended.
    For example if the application fqdn is 'avr.emory.edu', this variable is set to 0, and the workspace is test, the output will be avr-test.emory.edu.
    If the workspace is 'prod' then nothing is appended to the fqdn and the address on the alb would be 'avr.emory.edu'. 
    EOF
}

variable "ec2_instance_type" {
    default = "t3.micro"
    description = "Instance type or size"
}

variable "ec2_keyname" {
    description = "The name of the key in AWS that the ec2 will use for SSH login"
}

variable "ec2_common_name" {
    description = <<EOF
      Name the ec2 will be referred to, not the Name tag.
      Examples include "web", "redis", etc.
      EOF
}

variable "ec2_volume_size" {
  type = number
  default = 150
  description = "The root volume size of the ec2"
}

variable "subnet_id" {
    description = "Subnet id for the EC2"
  
}

variable "vpc_cidr_block" {
    description = "Cidr block for VPC ingress"
}

variable "ssh_cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
  description = "List of cidr blocks the compose ec2 will allow SSH access from, defaults to the entire internet"
}

variable "tags" {
  type    = map(string)
  default = {}
  description = "Map of tags, will be added to the common tags local"
}