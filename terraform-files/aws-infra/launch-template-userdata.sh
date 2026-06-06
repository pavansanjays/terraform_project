#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd

mkdir -p /var/www/html/launch
echo "<h1>This is laucnh template Page</h1>" > /var/www/html/launch/index.html