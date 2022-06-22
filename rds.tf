# MySQL RDS Instance
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "root"
  password             = "test1234"
  parameter_group_name = "default.mysql5.7"
  storage_encrypted = true
  kms_key_id = "${aws_kms_key.my_kms_key.arn}"
  vpc_id = "${aws_vpc.qa-prod-vpc.id}"
  skip_final_snapshot  = true
  depends_on = [aws_kms_key.my_kms_key, aws_vpc.qa-prod-vpc]

  tags = {
    Name = "RDS-Terra"
  }
}