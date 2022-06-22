#  EC2 Instance 1
resource "aws_instance" "QA_Pub1" {
    ami = var.ami
    instance_type = "t2.micro"
    key_name = "nimesa-developers"

    #root disk
    root_block_device {
        encrypted = true
        kms_key_id = "${aws_kms_key.my_kms_key.arn}"
    }

    # ebs_block_device {
    #     device_name           = "/dev/xvda"
    #     volume_size           = "5"
    #     volume_type           = "gp2"
    #     encrypted             = true
    #     kms_key_id = "${aws_kms_key.my_kms_key.arn}"
    #     delete_on_termination = true
    # }



    # VPC
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.public-allowed.id}"]
    depends_on = [aws_kms_key.my_kms_key, aws_vpc.qa-prod-vpc]

    tags = {
    Name = "Server-1"
    }

}

#  EC2 Instance 2
resource "aws_instance" "QA_Pub2" {
    ami = var.ami
    instance_type = "t2.micro"
    key_name = "nimesa-developers"
    root_block_device {
        encrypted = true
        kms_key_id = "${aws_kms_key.my_kms_key.arn}"
    }

    # VPC
    subnet_id = "${aws_subnet.prod-subnet-public-2.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.public-allowed.id}"]
    depends_on = [aws_kms_key.my_kms_key]
    tags = {
    Name = "Server-2"
    }
}


# resource "aws_ebs_volume" "example" {
#   availability_zone = "us-west-2a"
#   size              = 40

#   tags = {
#     Name = "HelloWorld"
#   }
# }

# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.example.id
#   instance_id = aws_instance.web.id
# }