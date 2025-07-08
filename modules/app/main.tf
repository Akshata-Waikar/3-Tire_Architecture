resource "aws_instance" "app" {
  count = 2
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = element(var.private_subnets, count.index)
  vpc_security_group_ids = [var.security_group_id]
  key_name = var.app_key_name
  tags = { Name = "app-${count.index+1}" }

 provisioner "remote-exec" {
   inline = [
     "sudo apt update  && sudo apt upgrade -y",
     "sudo apt install php php-fpm -y",
     "sudo systemctl enable php8.1-fpm",
     "sudo systemctl start php8.1-fpm"
   ]
   connection {
     type = "ssh"
     user = "ubuntu"
     host = self.private_ip
     private_key = var.app_private_key
}
}
}

output "instance_ids" {
  value = aws_instance.app[*].id
}
output "app_private_ips" {
  value = aws_instance.app[*].private_ip
}
