#Load Balancer
resource "aws_lb" "asg_lb" {
  name               = "my-lb"
  internal           = false #accesing from the internet so NOT internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [data.aws_subnet.pub_subnet_1.id, data.aws_subnet.pub_subnet_3.id]

  tags = {
    Environment = "my-lb"
  }
}

#Target groups for load balancer
resource "aws_lb_target_group" "blue-tg" {
  name        = "blue-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.my_vpc.id
}

resource "aws_lb_target_group" "green-tg" {
  name        = "green-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.my_vpc.id
}

#association of the instances to the target groups
resource "aws_autoscaling_attachment" "blue_asg_tg" {
  autoscaling_group_name = aws_autoscaling_group.blue_asg.id
  lb_target_group_arn    = aws_lb_target_group.blue-tg.arn
}

resource "aws_autoscaling_attachment" "green_asg_tg" {
  autoscaling_group_name = aws_autoscaling_group.green_asg.id
  lb_target_group_arn    = aws_lb_target_group.green-tg.arn
}

#listener for load balancer
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.asg_lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  #roul of the listener
  default_action {
    type = "forward"

    #Configuration block for creating an action that distributes requests among one or more target groups.
    forward {
      target_group {
        arn = aws_lb_target_group.blue-tg.arn
      }
      target_group {
        arn = aws_lb_target_group.green-tg.arn
      }
    }
  }
}