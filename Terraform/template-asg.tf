resource "aws_launch_template" "wordpress_lt" {
  name_prefix   = "wordpress-template-"
  image_id      = "ami-04f167a56786e4b09" #U-22
  instance_type = "t2.micro"
  key_name      = "om-key" # SSH key - Grb .pem Lw Mnf34

  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 php php-mysql libapache2-mod-php mysql-clien                         t -y
  EOF
  )

    tags = {
      Name = "wordpress-instance"
    }
  }

resource "aws_autoscaling_group" "wordpress_asg" {
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  target_group_arns   = [aws_lb_target_group.wordpress_tg.arn]

  launch_template {
    id      = aws_launch_template.wordpress_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "wordpress-asg-instance"
    propagate_at_launch = true
  }
}