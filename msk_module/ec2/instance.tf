resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.instance.id
}


resource "aws_ebs_volume" "example" {
  availability_zone = "us-west-2a"
  size              = 20
}


resource "aws_instance" "instance" {
  ami           = var.pub_ami
  associate_public_ip_address =  "true"
  instance_type = var.pubinstance_type
  key_name = var.instancekey_name
  subnet_id = var.subpubid
  vpc_security_group_ids = [ var.sg_id ]
  tags = {
    Name = "jumpbox"
  }

    provisioner "remote-exec" {
    inline = ["echo 'Waiting for server to be initialized...'"]

    connection {
      type        = "ssh"
      agent       = false
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/opsree/Downloads/pem/ubuntu2.pem")
    }
  }

  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook \
        -i '${self.public_ip},' \
        -u ubuntu \
         -e "broker_endpoint=${var.broker} database_host=${var.database_endpoint}  database_server_name=${var.database_server_name}  database=${var.database} table=${var.table} database_port=${var.database_port}  database_password=${var.database_password} database_user=${var.database_user}  database_id=${var.database_id}"\
        --private-key /home/opsree/Downloads/pem/ubuntu2.pem \
        /home/opsree/ansible-role/dabezeium-ansible/main.yml 
    EOT  
  }
}
  



