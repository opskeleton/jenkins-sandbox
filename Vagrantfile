# -*- mode: ruby -*-
# vi: set ft=ruby :

update = <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak s/us.archive/il.archive/g /etc/apt/sources.list
  sudo aptitude update 
  touch /tmp/up
fi
SCRIPT


Vagrant.configure("2") do |config|

  env  = ENV['PUPPET_ENV'] 
  env ||= 'dev'

  config.vm.define :jenkins do |node|
    node.vm.box = 'ubuntu-14.04.1_puppet-3.7.3'
    node.vm.network :public_network,  { bridge: 'eth0' }
    node.vm.hostname = 'jenkins.local'
    node.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
    end

    node.vm.provision :shell, :inline => update
    node.vm.provision :puppet do |puppet|
      puppet.manifests_path = 'manifests'
      puppet.manifest_file  = 'default.pp'
      puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"
    end

  end

end
