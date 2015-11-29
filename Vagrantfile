
# vi: set ft=ruby :

update = <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak s/us.archive/il.archive/g /etc/apt/sources.list
  sudo aptitude update 
  touch /tmp/up
fi
SCRIPT


Vagrant.configure("2") do |config|

  env = ENV['PUPPET_ENV'] || 'dev'
  # device = ENV['VAGRANT_BRIDGE'] || 'eth0'

  config.vm.define :jenkins do |node|
    node.vm.box = 'ubuntu-15.04_puppet-3.8.2'
    node.vm.provider 'libvirt'
    node.vm.hostname = 'jenkins.local'
    # node.vm.network :public_network, :bridge => device , :dev => device


    node.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
    end

    node.vm.provider :libvirt do |domain, o|
      domain.uri = 'qemu+unix:///system'
      domain.host = 'jenkins.local'
      domain.memory = 2048
      domain.cpus = 2
      o.vm.synced_folder './', '/vagrant', type: '9p'
    end

    node.vm.provision :shell, :inline => update
    node.vm.provision :puppet do |puppet|
      puppet.manifests_path = 'manifests'
      puppet.manifest_file  = 'default.pp'
      puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"
    end

  end

end
