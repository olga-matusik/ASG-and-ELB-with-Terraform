#!/bin/bash

#updating apt-get and installing apache2
sudo apt-get update -y
sudo apr-get install apache2 -y

#creating file with some html code
#using variables from terraform
cat <<EOF >/var/www/html.index.html
<html> 
<title>Talent Academy Exercise With ASG and ELB</title>
    <body style="background-color:${color};">
    <h1>This is ${version} !!!<h1>
    </body>
</html>
EOF

#restarting apache2
sudo service apache2 restart


