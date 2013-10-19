Vagrant::Config.run do |config|
    # Configure the VM box to use
    config.vm.box = 'precise32'
    config.vm.box_url = 'http://files.vagrantup.com/precise32.box'

    # Configure network and port forwarding
    config.vm.network :hostonly, "33.33.33.10"
    config.vm.forward_port 80, 8080     # HTTP
    config.vm.forward_port 3306, 3306   # MySQL
    config.vm.forward_port 27017, 27017 # MongoDB

    # Configure shared folders
    config.vm.share_folder "vagrant-root", "/vagrant", ".", :nfs => true
    config.vm.share_folder "www", "/var/www", "..", :nfs => true

    # Configure provisioning
    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.module_path = "puppet/modules"
    end
end
