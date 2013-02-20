

#!/bin/bash

echo "Creating a deploy user, and user group..."

/bin/grep -i "^deployers" /etc/group
if [ $? -eq 0 ]; then
  echo "Group deployers already exists"
else
  echo "Creating group deployers"
  groupadd deployers
fi

/bin/grep -i "^deploy" /etc/passwd
if [ $? -eq 0 ]; then
  usermod -a -G deployers deploy
  echo "User deploy already exists"
else
  useradd -m deploy
  echo "Password for deploy user?"
  read password
  passwd deploy
  ${password}
  usermod -a -G deployers deploy
fi


