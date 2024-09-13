# IAM
resource "aws_iam_role" "foo" {
  name = "foo-ec2"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "foo_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.foo.name
}

resource "aws_iam_role_policy" "foo_s3" {
  name   = "app-foo-s3-artifact-download"
  role   = aws_iam_role.foo.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::foo-deploy/auth/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "foo" {
  name = "foo-ec2-profile"
  role = aws_iam_role.foo.name
}

# EC2
resource "aws_instance" "foo" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  iam_instance_profile        = aws_iam_instance_profile.foo.name
  subnet_id                   = var.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.foo.id]
  ebs_optimized               = true
  #user_data_replace_on_change = false
  user_data                   = "${file("./userdata.sh.tpl")}"

  root_block_device {
    # only used for OS and linux packages
    volume_type = "gp3"
    volume_size = "20"
    tags = {
      Name = var.ec2_name
    }
  }

  tags = {
    Name = var.ec2_name
  }
}

# SG
resource "aws_security_group" "foo" {
  name        = "${var.ec2_name}-sg"
  description = "EC2 SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http any inbound"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "any outbound"
  }

  tags = {
    Name = var.ec2_name
  }
}
