resource "aws_security_group" "ec2_sg" {
  name        = "${local.namespace}-${var.ec2_common_name}"
  description = "${title(var.ec2_common_name)} Host Security Group"
  vpc_id      = var.vpc_id
  tags        = local.common_tags
}

resource "aws_security_group_rule" "sg_web_80" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr_block]
}

resource "aws_security_group_rule" "sg_web_443" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "ingress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr_block]
}

resource "aws_security_group_rule" "sg_ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = var.ssh_cidr_blocks
}

resource "aws_security_group_rule" "sg_egress" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}