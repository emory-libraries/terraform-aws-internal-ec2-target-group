output "ec2_private_ip" {
    value = aws_instance.ec2.private_ip
    description = "Private IP address of EC2"
}

output "ec2_instance_id" {
    value = aws_instance.ec2.id
    description = "EC2 instance ID"
}

output "ec2_ami" {
    value = aws_instance.ec2.ami
    description = "AMI of EC2"
}