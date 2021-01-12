resource "aws_security_group" "ec2_sg" {
  name        = "${local.namespace}-compose"
  description = "Compose Host Security Group"
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


resource "aws_security_group_rule" "sg_ssh" {
  security_group_id = aws_security_group.compose.id
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = var.ssh_cidr_blocks
}

resource "aws_security_group_rule" "compose_egress" {
  security_group_id = aws_security_group.compose.id
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}