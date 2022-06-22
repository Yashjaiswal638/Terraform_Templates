# All SGs are defined here

resource "aws_security_group" "public-allowed" {
    vpc_id = "${aws_vpc.qa-prod-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    depends_on = [aws_vpc.qa-prod-vpc]

    tags = {
        Name = "Public-Access"
    }
}

resource "aws_security_group" "private-allowed" {
    vpc_id = "${aws_vpc.qa-prod-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    depends_on = [aws_vpc.qa-prod-vpc]

    tags = {
        Name = "Private-Access"
    }
}


resource "aws_security_group" "terramino_instance" {
  name = "learn-asg-terramino-instance"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups    = ["${aws_security_group.public-allowed.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups    = ["${aws_security_group.public-allowed.id}"]
  }

  vpc_id = "${aws_vpc.qa-prod-vpc.id}"
  depends_on = [aws_vpc.qa-prod-vpc]

}


resource "aws_security_group" "terramino_lb" {
  name = "learn-asg-terramino-lb"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.qa-prod-vpc.id}"
  depends_on = [aws_vpc.qa-prod-vpc]

}