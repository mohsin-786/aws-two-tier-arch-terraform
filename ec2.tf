resource "aws_launch_template" "template" {
  name_prefix            = "template"
  image_id               = var.ami
  instance_type          = var.type
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  user_data              = filebase64("${path.module}/nginx.sh")
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.privnet-1.id, aws_subnet.privnet-2.id]
  target_group_arns   = [aws_lb_target_group.test.arn]

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}

resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.type
  key_name               = "sin"
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  subnet_id              = aws_subnet.pubnet-1.id
  tags = {
    Name = "Bastion"
  }
}

