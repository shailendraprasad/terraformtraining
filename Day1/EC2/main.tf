provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "nyec22021" {
    ami = "ami-0742b4e673072066f"
    instance_type = "t2.micro"
    tags = {
      "Name" = "nsp-myec2-2021"
    }
}

output "myec2ip" {
    value = aws_instance.nyec22021.public_ip
}

output "myec2ipprivate" {
    value = aws_instance.nyec22021.private_ip
}