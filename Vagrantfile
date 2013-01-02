# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.define :jenkins do |jenkins|
    jenkins.vm.box = 'ubuntu-12.10'
    jenkins.vm.network :bridged
    jenkins.vm.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 4]
    jenkins.vm.host_name = 'jenkins'
    jenkins.vm.provision :puppet, :options => ["--modulepath=/vagrant/modules:/vagrant/static-modules"]
    jenkins.vm.network :hostonly, "192.168.1.15"
  end

end
