module "ec2" {
  source  = "shailendraprasad/ec2module/nsp"
  version = "1.0.0"
  instanceCount = 1
  tags = {
      ENV : "DEV"
  }
}
  

module "s3" {
  source = "../s3module"
  bucket_name = "bucketnamedev-nsp"
}