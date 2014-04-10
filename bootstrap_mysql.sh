#!/usr/bin/env bash
MYSQL_ROOT_PASS="root"

sudo apt-get -y update
sudo debconf-set-selections <<< "mysql-server-5.1 mysql-server/root_password password $MYSQL_ROOT_PASS"
sudo debconf-set-selections <<< "mysql-server-5.1 mysql-server/root_password_again password $MYSQL_ROOT_PASS"
sudo apt-get -y install mysql-server


#set mysql to listen on all interfaces
sed -i '/bind-address/c\bind-address = 0.0.0.0' /etc/mysql/my.cnf

#create a user that can log on remotely
mysql --password="$MYSQL_ROOT_PASS" -e "CREATE USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASS';"
mysql --password="$MYSQL_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"

sudo service mysql restart