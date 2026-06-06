#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd

mkdir -p /var/www/html/app2
echo "<h1>hellt s App2 Page</h1>" > /var/www/html/app2/index.html