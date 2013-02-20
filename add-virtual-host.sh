# This script is a modified version of another one found here: https://www.siamnet.org/Wiki/Ubuntu-BASHScriptToCreateVirtualHost

#!/bin/bash

echo "Enter a domain (e.g. example.com):";
read domain;
echo ""

### Check to see if $domain exists

if [[ ! -e /etc/apache2/sites-available/${domain} ]]; then
        echo "${domain} will be created"
        echo "Are you sure you want to do this?"
        read q
        if [[ "${q}" == "yes" ]] || [[ "${q}" == "y" ]]; then

                if [[ ! -e /var/www/${domain} ]]; then
                        mkdir /var/www/${domain}
                        mkdir /var/www/${domain}/current
                fi

                echo "
### ${domain}

<VirtualHost *:80>
  DocumentRoot /var/www/${domain}/current
  ServerName ${domain}

  ScriptAlias /cgi-bin /var/www/${domain}/cgi-bin

  <Directory /var/www/${domain}/current>
    Options All
    AllowOverride All
  </Directory>

  LogLevel warn
  CustomLog /var/log/apache2/access.log combined
</VirtualHost>" >> /etc/apache2/sites-available/${domain}

                echo "Enabling Sites"
                a2ensite ${domain}
                echo "Restart Apache?"
                read q
                if [[ "${q}" == "yes" ]] || [[ "${q}" == "y" ]]; then
                        /etc/init.d/apache2 reload
                fi
        fi
else
        echo "${domain} already exists"
fi