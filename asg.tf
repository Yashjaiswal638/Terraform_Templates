resource "aws_lb_target_group" "hashicups" {
  name     = "learn-asg-hashicups"
  port     = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.qa-prod-vpc.id}"
  depends_on = [aws_kms_key.my_kms_key, aws_vpc.qa-prod-vpc]

}

resource "aws_launch_configuration" "terramino" {
  name_prefix     = "learn-terraform-aws-asg-"
  image_id        = "ami-068257025f72f470d"
  instance_type   = "t2.micro"
#   user_data       = file("user-data.sh")
  security_groups = ["${aws_security_group.public-allowed.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "terramino" {
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.terramino.name
  vpc_zone_identifier       = ["${aws_subnet.prod-subnet-public-1.id}", "${aws_subnet.prod-subnet-public-2.id}"]
  depends_on = [aws_kms_key.my_kms_key, aws_vpc.qa-prod-vpc]

}

resource "aws_lb" "terramino" {
  name               = "learn-asg-terramino-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.public-allowed.id}"]
  subnets       = ["${aws_subnet.prod-subnet-public-1.id}", "${aws_subnet.prod-subnet-public-2.id}"]
  depends_on = [aws_kms_key.my_kms_key, aws_vpc.qa-prod-vpc]

}

resource "aws_lb_listener" "terramino" {
  load_balancer_arn = aws_lb.terramino.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terramino.arn
  }
}

resource "aws_lb_target_group" "terramino" {
   name     = "learn-asg-terramino"
   port     = 80
   protocol = "HTTP"
   vpc_id = "${aws_vpc.qa-prod-vpc.id}"
  depends_on = [aws_kms_key.my_kms_key, aws_vpc.qa-prod-vpc]

}

resource "aws_autoscaling_attachment" "terramino" {
  autoscaling_group_name = aws_autoscaling_group.terramino.id
  alb_target_group_arn   = aws_lb_target_group.terramino.arn
}
