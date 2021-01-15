resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.amzn.id
  instance_type               = var.ec2_instance_type
  key_name                    = var.ec2_keyname
  subnet_id                   = var.subnet_id
  #iam_instance_profile        = aws_iam_instance_profile.compose.name
  tags = merge(
    local.common_tags,
    {
      "Name" = "${local.namespace}-${var.ec2_common_name}"
    },
  )

  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = "standard"
  }

  vpc_security_group_ids = concat([aws_security_group.ec2_sg.id], var.additional_security_group_ids)

  lifecycle {
    ignore_changes = [ami]
  }
}

data "aws_ami" "amzn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["137112412989"] # Amazon
}