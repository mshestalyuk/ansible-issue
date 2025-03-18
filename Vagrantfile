# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.define "wp"
  config.vm.network :private_network, ip: "192.168.56.10"
  config.ssh.insert_key = false
  config.vm.hostname = "wp-servers.test"
  config.vm.provider :virtualbox do |v|
    v.name = "ubuntu"
    v.memory = 4086
    v.cpus = 4
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # Enable provisioning with Ansible.
  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "playbook.yml"
    ansible.groups = {
      "wp-servers" => ["wp"]
    }
  end
end
