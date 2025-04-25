resource "aws_instance" "vm" {
   ami                    = "ami-0f9de6e2d2f067fca"
  instance_type          = "t2.micro"

   tags = {
    Name = "Terraform-Test Provision"
  }
}