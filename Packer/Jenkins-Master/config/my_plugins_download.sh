#!/bin/bash

# This script is used to download all the plugins from the plugins.txt file
cd /var/lib/jenkins/plugins/
cat /tmp/config/plugins.txt | parallel --gnu "wget {}"
# cat links.txt | wget -i
