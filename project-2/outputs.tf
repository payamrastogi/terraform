output "public-ip-ubuntu_instance-project-2-20220824-01" {
    value = aws_eip.eip-project-2-20220824-01.public_ip
}
 
output "ami-ubuntu_instance-project-2-20220824-01" {
    value = aws_instance.ubuntu_instance-project-2-20220824-01.ami
}

output "id-ubuntu_instance-project-2-20220824-01" {
    value = aws_instance.ubuntu_instance-project-2-20220824-01.id
}