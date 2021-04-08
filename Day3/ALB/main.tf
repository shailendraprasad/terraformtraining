resource "aws_security_group" "albsg" {
  name = "alb-sg-nsp-new"
  vpc_id = "vpc-03f094db73a5298e9"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }
}

resource "aws_alb" "alb-nsp" {
  name = "alb-nsp-new"
  internal = false
  subnets = [ "subnet-019f73092e25c1591", "subnet-0105aa6b9327f5cc1" ]
  security_groups = [ aws_security_group.albsg.id ]
}

resource "aws_lb_target_group" "myalbtg" {
  name     = "myalb-tg-nsp-new"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-03f094db73a5298e9"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_alb.alb-nsp.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myalbtg.arn
  }
}

