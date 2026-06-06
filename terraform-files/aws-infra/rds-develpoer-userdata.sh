#!/bin/bash

# Update packages
yum update -y

# Install MySQL client (MariaDB)
yum install -y mariadb

# Install telnet for network testing
yum install -y telnet

# Optional: install netcat (better alternative to telnet)
yum install -y nc

# Create a simple info file
cat <<EOF > /home/ec2-user/README_DB_TEST.txt
DB Testing Commands:

1. Check network:
   telnet <RDS-ENDPOINT> 3306
   OR
   nc -zv <RDS-ENDPOINT> 3306

2. Connect to DB:
   mysql -h <RDS-ENDPOINT> -u dbadmin -p

Replace <RDS-ENDPOINT> with your actual RDS endpoint.
EOF

# Set permissions
chown ec2-user:ec2-user /home/ec2-user/README_DB_TEST.txt


# //using in bastion seerver to login by develpoer not user to check so we donwload telnet mariadb in our bastion server and go into rd server to check error