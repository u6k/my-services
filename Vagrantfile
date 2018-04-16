# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/digitalocean.yml"
    ansible.inventory_path = "provisioning/hosts"
    ansible.limit = 'all'
  end
end
