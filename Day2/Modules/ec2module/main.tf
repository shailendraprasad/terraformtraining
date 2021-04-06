resource "aws_instance" "myec22021" {
  ami           = var.amiid
  instance_type = "t2.micro"
  count         = var.instanceCount
  tags = {
    "Name" = "nsp-myec2-2021-${var.tags[count.index]}"
  }
}

output "myec2ip" {
  value = aws_instance.myec22021[*].public_ip
}

output "myec2ipprivate" {
  value = aws_instance.myec22021[*].private_ip
}
