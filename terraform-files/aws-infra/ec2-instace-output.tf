output "ec2-public-instace-id" {
  value = module.ec2-instace-public.id
}

output "ec2-public-instace-ip" {
  value = module.ec2-instace-public.public_ip
}

# output "ec2-private-instace-id" {
#   value = [for i in module.ec2-instace-private:i.id]
# }

# output "ec2-private-instace-ip" {
#   value = [for i in module.ec2-instace-private:i.private_ip]
# }

output "app1-ec2-id" {
  value = [for i in module.app1-instace-private:i.id]
}

output "app1-ec2-ip" {
  value = [for i in module.app1-instace-private:i.private_ip]
}

output "app2-ec2-id" {
  value = [for i in module.app2-instace-private:i.id]
}

output "app2-ec2-ip" {
  value = [for i in module.app2-instace-private:i.private_ip]
}