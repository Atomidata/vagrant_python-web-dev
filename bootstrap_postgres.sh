#!/usr/bin/env bash

PGSQL_VERSION=9.1

PG_HBA=/etc/postgresql/$PGSQL_VERSION/main/pg_hba.conf
PG_CONF=/etc/postgresql/$PGSQL_VERSION/main/postgresql.conf

#get the ip address
IP_ADDR=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if ! command -v psql; then
    apt-get install -y postgresql-$PGSQL_VERSION libpq-dev
fi

if ! grep -q $IP_ADDR $PG_HBA; then
    
    echo "host    all         all         $IP_ADDR/24          trust" >> $PG_HBA
    /etc/init.d/postgresql reload
fi

if ! grep -q "        listen_addresses = '*'" $PG_CONF; then
    echo "        listen_addresses = '*'" >> $PG_CONF
    /etc/init.d/postgresql restart
fi

#set the password for the postgres db user
su - postgres -c "psql -tAc \"alter user postgres with password 'postgres';\""

#create the vagrant user and set the password
$VAGRANT_EXISTS=$(su - postgres -c "psql postgres -tAc \"SELECT 1 FROM pg_roles WHERE rolname='vagrant'\"")
if [ ! "$VAGRANT_EXISTS" == "1" ]; then
    su - postgres -c "psql -tAc \"CREATE USER vagrant WITH PASSWORD 'vagrant';\""
fi