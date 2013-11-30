# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  env  = ENV['PUPPET_ENV'] 
  env ||= 'dev'

  config.vm.define :jenkins do |jenkins|
    jenkins.vm.box = 'ubuntu-13.04_puppet-3.3.1'
    jenkins.vm.network :public_network,  { bridge: 'eth0' }
    jenkins.vm.hostname = 'jenkins'
    jenkins.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
    end

    jenkins.vm.provision :puppet do |puppet|
      puppet.manifests_path = 'manifests'
      puppet.manifest_file  = 'default.pp'
      puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"
    end

  end

end
