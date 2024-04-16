provider "aws" {
  region = "eu-central-1"
}

// ami list https://cloud-images.ubuntu.com/locator/ec2/
// verify https://eu-central-1.console.aws.amazon.com/ec2/home?region=eu-central-1#Home:
// graph https://bit.ly/2mPbxmg

resource "aws_launch_configuration" "example" {
  image_id        = "ami-09042b2f6d07d164a"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
#!/bin/bash
echo "Hello, World" > index.html
nohup busybox httpd -f -p ${var.server_port} &
EOF

  lifecycle {
    create_before_destroy = true
  }
}

// single instance example
/*resource "aws_instance" "example" {
  ami                    = "ami-09042b2f6d07d164a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
#!/bin/bash
echo "Hello, World" > index.html
nohup busybox httpd -f -p ${var.server_port} &
EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
  }
}*/
