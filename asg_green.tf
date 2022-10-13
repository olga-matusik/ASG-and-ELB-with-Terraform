resource "aws_launch_template" "lt_green_1" {
  name                   = var.name_green
  image_id               = data.aws_ami.ami_name.id
  instance_type          = var.instance_type
  key_name               = var.keypair_name
  vpc_security_group_ids = [aws_security_group.server_sg.id]
  #need to use base64encode 
  user_data = base64encode(templatefile("${path.module}/user-data.sh.tpl",
    {
      color   = "green",
      version = "Green Website"
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "green-web"
    }
  }
}

resource "aws_autoscaling_group" "green_asg" {
  #availability_zones = ["us-east-1a"] this is for EC2-Classic, so NOT GOOD
  vpc_zone_identifier = [data.aws_subnet.priv_subnet_2.id]
  desired_capacity    = 2
  max_size            = 2
  min_size            = 1

  launch_template {
    id      = aws_launch_template.lt_green_1.id
    version = "$Latest"
  }
}