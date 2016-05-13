# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/wily64"

  config.vm.network "private_network", ip: "192.168.34.10"
  config.vm.network "forwarded_port", guest: 22, host: 1233
  # cassandra
  config.vm.network "forwarded_port", guest: 9042, host: 19042
  config.vm.network "forwarded_port", guest: 9160, host: 19160
  # spark
  config.vm.network "forwarded_port", guest: 8080, host: 18080
  config.vm.network "forwarded_port", guest: 7077, host: 17077
  config.vm.network "forwarded_port", guest: 8081, host: 18081

  config.vm.provider "virtualbox" do |vb|
    vb.name = "cassandra-spark"
    vb.gui = false
    vb.memory = "8192"
    vb.cpus = 4
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose = "v"
  end
end
