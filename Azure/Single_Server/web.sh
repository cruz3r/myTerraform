#!/bin/bash

# Create index.html
echo "Hello from : " `hostname` > /tmp/index.html
# run web server
sudo nohup busybox httpd -h /tmp -p "8080"