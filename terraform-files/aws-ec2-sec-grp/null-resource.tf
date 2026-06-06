resource "null_resource" "null-resource" {
  connection {
    user = "ec2-user"
    private_key = file("${path.module}/private-key.pem")
    type = "ssh"
    host = aws_eip.aws-eip.public_ip
  }

  provisioner "local-exec" {
    command = "echo 'inserting data into output file' >> output.txt"
    working_dir = "output/"
  }

  # provisioner "remote-exec" {
  #   inline = [ "sudo chmod 400 /tmp/private-key.pem" ]
  # }

  # provisioner "file" {
  #   source = "${path.module}/private-key.pem"
  #   destination = "/tmp/private-key.pem"
  # }
}