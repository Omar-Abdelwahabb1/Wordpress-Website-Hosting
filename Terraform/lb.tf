#  Security Group for ALB
resource "aws_security_group" "wordpress_alb_sg" {
  name        = "wordpress-alb-sg"
  description = "Allow HTTP and HTTPS traffic to ALB"
  vpc_id      = aws_vpc.main.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }
}
# lb
resource "aws_lb" "wordpress_alb" {
  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.wordpress_alb_sg.id]
  subnets           = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true

  tags = {
    Name = "wordpress-alb"
  }
}

resource "aws_lb_target_group" "wordpress_tg" {
  name     = "wordpress-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    healthy_threshold   = 2
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "wordpress-tg"
  }
}

resource "aws_lb_listener" "wordpress_listener" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = "80"
  protocol          = "HTTP"
 # sendit to target group
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_tg.arn
  }
}
