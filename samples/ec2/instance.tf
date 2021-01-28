// setup ssh keys for resource
resource "aws_key_pair" "lab-key" {
    key_name = "lab-key-${uuid()}"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

// configure ec2
resource "aws_instance" "lab-instance" {
    ami           = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
    key_name      = aws_key_pair.lab-key.key_name
    monitoring    = true

    // upload initilization script
    provisioner "file" {
        source = "init.sh"
        destination = "/tmp/init.sh"
    }

    // update permissions and execute init.sh
    provisioner "remote-exec" {
        inline = [
            "chmod 755 /tmp/init.sh",
            "sudo /tmp/init.sh",
        ]
    }
    // ssh creds
    connection {
        type = "ssh"
        host = self.public_ip
        user = var.INSTANCE_USERNAME
        private_key = file(var.PATH_TO_PRIVATE_KEY)
        }
}

output "ip" {
    value = aws_instance.lab-instance.public_ip
}

