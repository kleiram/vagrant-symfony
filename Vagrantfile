Vagrant.configure("2") do |config|
    # Configure the box to use
    config.vm.box       = 'precise64'
    config.vm.box_url   = 'http://files.vagrantup.com/precise64.box'

    # Configure the network interfaces
    config.vm.network :private_network, ip:    "192.168.33.10"
    config.vm.network :forwarded_port,  guest: 8080, host: 8080
    config.vm.network :forwarded_port,  guest: 8081, host: 8081
    config.vm.network :forwarded_port,  guest: 3306, host: 3306

    # Configure shared folders
    config.vm.synced_folder ".",  "/vagrant"
    config.vm.synced_folder "..", "/var/www"

    # Configure VirtualBox
    config.vm.provider :virtualbox do |provider|
        provider.customize [ "modifyvm", :id, "--memory", "512" ]
    end

    # Provision the box
    config.vm.provision :puppet do |puppet|
        puppet.manifests_path   = "puppet/manifests"
        puppet.manifest_file    = "site.pp"
        puppet.module_path      = "puppet/modules"
    end
end
