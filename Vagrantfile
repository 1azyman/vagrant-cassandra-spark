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
    vb.memory = "10240"
    vb.cpus = 6

    file_to_disk = "/data/virtual-box/" + vb.name + "/cassandra-data.vdi"

    if ARGV[0] == "up" && ! File.exist?(file_to_disk)
      vb.customize [
                       'createhd',
                       '--filename', file_to_disk,
                       '--format', 'VDI',
                       '--size', 100 * 1024 # 100 GB
                   ]
      vb.customize [
                       'storageattach', :id,
                       '--storagectl', 'SATAController', # The name may vary
                       '--port', 1,
                       '--device', 0,
                       '--type', 'hdd',
                       '--medium', file_to_disk
                   ]
    end
  end

  config.vm.provision "shell", path: "./mount-drive.sh"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose = "v"
  end
end
