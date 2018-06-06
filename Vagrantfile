# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"

  config.vm.network :forwarded_port, host: 10022, guest: 10022

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/debian-for-docker.yml"
    ansible.inventory_path = "provisioning/hosts"
    ansible.limit = 'all'
  end
end
