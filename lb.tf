resource "aws_lb" "main" {
  name               = "h4b-ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]

  # access_logs {
  #   bucket = "${aws_s3_bucket.alb_log.bucket}"
  # }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "mas_g_a" {
  load_balancer_arn = aws_lb.main.arn
  port              = "8091"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mars_g_a.arn
  }
}

resource "aws_lb_target_group" "main" {
  name        = "h4b-ecs-targetgroup"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
}

resource "aws_lb_target_group" "mars_g_a" {
  name        = "mars-g-a-targetgroup"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

}