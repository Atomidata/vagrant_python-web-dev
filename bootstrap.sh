#!/usr/bin/env bash
apt-get update -y
#apt-get upgrade -y

apt-get install -y software-properties-common python-software-properties
apt-get install -y git vim wget screen curl gnupg build-essential

apt-get install -y build-essential python python-dev python-setuptools python-pip

apt-get install -y libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev


# pip and virtualenv setup
if ! command -v pip; then
	easy_install -U pip
fi
if [[ ! -f /usr/local/bin/virtualenv ]]; then
	pip install -u virtualenv virtualenvwrapper stevedore
fi

if [[ ! -d  /home/vagrant/.virtualenvs ]]; then
	su - vagrant -c "mkdir -p /home/vagrant/.virtualenvs"
fi

cp /home/vagrant/.bashrc /home/vagrant/.bashrc.bak


if ! grep -q "WORKON_HOME=~/.virtualenvs" /home/vagrant/.bashrc; then
	echo "export WORKON_HOME=~/.virtualenvs" >> /home/vagrant/.bashrc
fi

if ! grep -q "source /usr/local/bin/virtualenvwrapper.sh" /home/vagrant/.bashrc; then
	echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/vagrant/.bashrc
fi
