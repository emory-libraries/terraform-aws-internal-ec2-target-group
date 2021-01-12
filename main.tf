resource "aws_instance" "compose" {
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

  vpc_security_group_ids = [
    aws_security_group.compose.id,
    aws_security_group.db_client.id,
  ]

  lifecycle {
    ignore_changes = [ami]
  }
}