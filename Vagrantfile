# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "hashicorp/precise64"
  #the base system
  config.vm.provision :shell, :path => "bootstrap.sh"
  #postgres
  config.vm.provision :shell, :path => "bootstrap_postgres.sh"
  #map the postgres port so that we can access it with tools from the host
  config.vm.network :forwarded_port, guest: 5432, host: 5321
  
end
