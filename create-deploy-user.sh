

#!/bin/bash

echo "Creating a deploy user, and user group..."

/bin/grep -i "^deployers" /etc/group
if [ $? -eq 0 ]; then
  echo "Group deployers already exists"
else
  echo "Creating group deployers"
  groupadd deployers
fi

/bin/grep -i "^deployer" /etc/passwd
if [ $? -eq 0 ]; then
  usermod -a -G deployers deployer
  echo "User deployer already exists"
else
  useradd -m deployer
  echo "Password for deployer user?"
  read password
  passwd deployer
  ${password}
  usermod -a -G deployers deployer
fi


