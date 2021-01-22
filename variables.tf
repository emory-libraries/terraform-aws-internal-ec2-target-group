variable "additional_security_group_ids" {
    default = []
    description = "List of security group ids that will be attached to the EC2."
}

variable "alb_listener_arn" {
    type = string
    description = "The listener arn of the ALB this EC2's target group will be attached to."
}

variable "ami_name_filter" {
  default = "amzn2-ami-hvm-*"
  description = "Name filter to search for AMIs, the latest AMI will be chosen. Default is Amazon Linux 2, if RHEL7 is desired use 'RHEL-7.?*GA*' , ignored if ec2_ami_id is selected"
}

variable "ami_owner_id" {
  default = "137112412989"
  description = "Owner ID for AMI search, default owner id is Amazon, for RedHat use '309956199498' , ignored if ec2_ami_id is selected"
}

variable "application_fqdn" {
  type = string
  description = <<EOF
    The fully qualified production domain name. This is name is used only by the application load balancer, not route53.
    Note that the template will also create another domain name for streaming that is streaming.{application_fqdn}.
    EOF
}

variable "application_fqdn_workspace_insertion_index" {
  default = 0
  description = <<EOF
    The application fqdn is split into a list at each '.', this variable is the index (first object is 0) where the workspace will be appended.
    For example if the application fqdn is 'avr.emory.edu', this variable is set to 0, and the workspace is test, the output will be avr-test.emory.edu.
    If the workspace is 'prod' then nothing is appended to the fqdn and the address on the alb would be 'avr.emory.edu'. 
    EOF
}

variable "ec2_ami_id" {
  default = null
  type = string
  description = "AMI that EC2 will be created from, if this optional variable is set, the variables ami_name_filter and ami_owner_id will be ignored"
}

variable "ec2_instance_type" {
    default = "t3.micro"
    description = "Instance type or size"
}

variable "ec2_keyname" {
    type = string
    description = "The name of the key in AWS that the ec2 will use for SSH login"
}

variable "ec2_common_name" {
    type = string
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
    type = string
    description = "Subnet id for the EC2"
}

variable "vpc_cidr_block" {
    type = string
    description = "Cidr block for VPC ingress"
}

variable "ssh_cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
  description = "List of cidr blocks the ec2 will allow SSH access from, defaults to the entire internet"
}

variable "stack_name" {
  default = "stack"
  description = "Name of the stack, helps delineate between different projects."
}

variable "tags" {
  type    = map(string)
  default = {}
  description = "Map of tags, will be added to the common tags local"
}

variable "vpc_id" {
  type = string
  description = "VPC that will be used by terraform, this VPC is called via data only, terraform will not attempt to manage the existence of the VPC"
}