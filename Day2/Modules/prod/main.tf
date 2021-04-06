module "ec2" {
  source = "../ec2module"
  instanceCount = 1
  tags = {
      ENV : "PROD"
  }
}