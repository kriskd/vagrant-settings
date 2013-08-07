#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
rm -rf /var/www
ln -fs /vagrant /var/www
apt-get install -y vim
# Add ServerName to httpd.conf
echo "ServerName localhost" > /etc/apache2/httpd.conf
# Setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/vagrant/Sites"
  ServerName localhost
  <Directory "/vagrant/Sites">
    Require all granted
  </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default
# Enable mod_rewrite
a2enmod rewrite
# Restart apache
service apache2 restart

# PHP 5.4
# -------
apt-get install -y libapache2-mod-php5
# Add add-apt-repository binary
apt-get install -y python-software-properties
# Install PHP 5.4
add-apt-repository ppa:ondrej/php5
# Update
apt-get update

# PHP stuff
# ---------
# Command-Line Interpreter
apt-get install -y php5-cli
# MySQL database connections directly from PHP
apt-get install -y php5-mysql
# cURL is a library for getting files from FTP, GOPHER, HTTP server
apt-get install -y php5-curl
# Module for MCrypt functions in PHP
apt-get install -y php5-mcrypt

# cURL
# ----
apt-get install -y curl

# Mysql
# -----
# Ignore the post install questions
export DEBIAN_FRONTEND=noninteractive
# Install MySQL quietly
apt-get -q -y install mysql-server-5.5

# Git
# ---
apt-get install -y git-core
apt-get install -y git

# Generate a SSH key pair
if [ ! -f /home/vagrant/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa
    echo "########### PUBLIC SSH KEY ###########"
    cat /home/vagrant/.ssh/id_rsa.pub
    echo "######################################"
fi

# Install Composer
# ----------------
curl -s https://getcomposer.org/installer | php
# Make Composer available globally
mv composer.phar /usr/local/bin/composer

# Install Ruby
# ------------
apt-get install -y ruby-full build-essential

# Install Rubygems
# ----------------
apt-get install -y rubygems

# Install Sass
# ------------
gem install sass

# Install Node JS and NPM
# ---------------
add-apt-repository ppa:richarvey/nodejs
apt-get update
apt-get install -y nodejs nodejs-dev npm

# Upgrade NPM
# -----------
npm update -g npm

# Grunt CLI
# ---------
npm install -g grunt-cli

# Grunt Compass
# -------------
gem install compass