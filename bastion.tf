resource "aws_launch_template" "template-bastion" {
  name_prefix            = "template-bastion"
  image_id               = var.ami
  instance_type          = var.type
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  user_data              = filebase64("${path.module}/bastion.sh")
}

resource "aws_autoscaling_group" "asg-bastion" {
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.pubnet-1.id, aws_subnet.pubnet-2.id]
  target_group_arns   = [aws_lb_target_group.test.arn]

  launch_template {
    id      = aws_launch_template.template-bastion.id
    version = "$Latest"
  }
}

