resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.instance.id
}

data "template_file" "instance_userdata" {
  template = file("../module/ec2/user_data.sh")
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
  user_data                   = data.template_file.instance_userdata.rendered
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
      scp -i /home/opsree/Downloads/pem/ubuntu2.pem \
        -r /home/opsree/ansible-role/sonarqube/sonar-ansible/roles/docker-dabezeium/templates/docker-compose.yml.j2 ubuntu@${self.public_ip}:/home/ubuntu/docker-compose.yml
    EOT  
  }
}
  



