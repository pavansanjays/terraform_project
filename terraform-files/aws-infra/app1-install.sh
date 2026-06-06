#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd

mkdir -p /var/www/html/app1
echo "<h1>App1 Page</h1>" > /var/www/html/app1/index.html