# KMS CMK Key
resource "aws_kms_key" "my_kms_key" {
  description         = "My KMS Keys for Data Encryption"
  is_enabled               = "true"

  tags = {
    Name = "keyTerra"
  }
}
