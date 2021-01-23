
resource "aws_security_group" "load_balancer_sg" {
  description = "Allow internet traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow traffic from public instances sg"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow traffic from public instances sg"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description = "allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "ec2_security_group" {
  description = "Allow internet traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "allow internet traffic"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }

  egress {
    description = "allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-${var.region}-allow-all-traffic"
  }
}
resource "aws_security_group" "ECS_security_sg" {
  description = "Allow internet traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "allow traffic from load balancer"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }

  egress {
    description = "allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-${var.region}-allow-all-traffic"
  }
}


