# terraform-aws-internal-ec2-target-group

Terraform module that will create an EC2 and attached it to an internal ALB.

Note that if using the __ami_name_filter__ and __ami_owner_id__ variables, the Template will ignore a more recent published AMI, to avoid destroying the EC2 when that may not be intended behavior.
To rebuild the EC2 with the most recent AMI, destroy it manually in the AWS Console, then reapply the Terraform template and the latest available AMI will be selected.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_security\_group\_ids | List of security group ids that will be attached to the EC2. | `list` | `[]` | no |
| alb\_listener\_arn | The listener arn of the ALB this EC2's target group will be attached to. | `string` | n/a | yes |
| ami\_name\_filter | Name filter to search for AMIs, the latest AMI will be chosen. Default is Amazon Linux 2, if RHEL7 is desired use 'RHEL-7.?\*GA\*' , ignored if ec2\_ami\_id is selected | `string` | `"amzn2-ami-hvm-*"` | no |
| ami\_owner\_id | Owner ID for AMI search, default owner id is Amazon, for RedHat use '309956199498' , ignored if ec2\_ami\_id is selected | `string` | `"137112412989"` | no |
| application\_fqdn | The fully qualified production domain name. This is name is used only by the application load balancer, not route53.<br>    Note that the template will also create another domain name for streaming that is streaming.{application\_fqdn}. | `string` | n/a | yes |
| application\_fqdn\_workspace\_insertion\_index | The application fqdn is split into a list at each '.', this variable is the index (first object is 0) where the workspace will be appended.<br>    For example if the application fqdn is 'avr.emory.edu', this variable is set to 0, and the workspace is test, the output will be avr-test.emory.edu.<br>    If the workspace is 'prod' then nothing is appended to the fqdn and the address on the alb would be 'avr.emory.edu'. | `number` | `0` | no |
| ec2\_ami\_id | AMI that EC2 will be created from, if this optional variable is set, the variables ami\_name\_filter and ami\_owner\_id will be ignored | `string` | `null` | no |
| ec2\_common\_name | Name the ec2 will be referred to, not the Name tag.<br>      Examples include "web", "redis", etc. | `string` | n/a | yes |
| ec2\_instance\_type | Instance type or size | `string` | `"t3.micro"` | no |
| ec2\_keyname | The name of the key in AWS that the ec2 will use for SSH login | `string` | n/a | yes |
| ec2\_volume\_size | The root volume size of the ec2 | `number` | `150` | no |
| ssh\_cidr\_blocks | List of cidr blocks the ec2 will allow SSH access from, defaults to the entire internet | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| stack\_name | Name of the stack, helps delineate between different projects. | `string` | `"stack"` | no |
| subnet\_id | Subnet id for the EC2 | `string` | n/a | yes |
| tags | Map of tags, will be added to the common tags local | `map(string)` | `{}` | no |
| vpc\_cidr\_block | Cidr block for VPC ingress | `string` | n/a | yes |
| vpc\_id | VPC that will be used by terraform, this VPC is called via data only, terraform will not attempt to manage the existence of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ec2\_ami | AMI of EC2 |
| ec2\_instance\_id | EC2 instance ID |
| ec2\_private\_ip | Private IP address of EC2 |
