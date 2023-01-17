provider "aws" {
  region = "ap-south-1" #mumbai region
}

resource "aws_instance" "sampleserver" {
  ami = "ami-0c1a7f89451184c8b" #this ami is specific to mumbai region
  instance_type = "t2.micro"
  tags = {
     Name = "local-provisioner"
  }

#this will run at creation
  provisioner "local-exec" {
     command = "echo Server IP address is ${self.private_ip}"
  }

#if you want to send output to a file
  #this will run at creation
  provisioner "local-exec" {
     command = "echo ${self.private_ip} > file_${aws_instance.sampleserver.id}.txt"
  }
  
#multiple times provisioner can be defined
    provisioner "local-exec" {
     working_dir = "/tmp"
     command = "echo ${aws_instance.sampleserver.private_ip} >> sampleserver-ips.txt"
  }
  
    provisioner "local-exec" {
     command = "echo ${aws_instance.sampleserver.private_ip} >> /tmp/sampleserver-ips.txt"
  }
  
#this will run at destroy
  provisioner "local-exec" {
     when = destroy
     command = "echo Server is destroyed"
  }
}
