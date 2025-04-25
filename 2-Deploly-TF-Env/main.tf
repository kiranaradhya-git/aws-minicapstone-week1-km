resource "aws_instance" "vm" {
   ami                    = "ami-092ca7dcd8e147cd3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow-http.id, aws_security_group.allow-ssh.id]

   tags = {
    Name = "Terraform-Host"
  }
}