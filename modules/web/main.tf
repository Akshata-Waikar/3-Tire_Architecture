resource "aws_instance" "web" {
  count           = 2
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = element(var.public_subnets, count.index)
  vpc_security_group_ids = [var.security_group_id]
  key_name        = var.web_key_name

  tags = {
    Name = "app-${count.index + 1}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = var.web_private_key
    }
  }
}

output "instance_ids" {
  value = aws_instance.web[*].id
}

output "web_private_ips" {
  value = aws_instance.web[*].private_ip
}
