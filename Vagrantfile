Vagrant::Config.run do |config|
    config.vm.box = 'precise32'
    config.vm.box_url = 'http://files.vagrantup.com/precise32'

    config.vm.network :hostonly, "33.33.33.10"
    config.vm.forward_port 80, 8080
    config.vm.forward_port 3306, 3306
    config.vm.share_folder "v-root", "vagrant", ".."

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.module_path = "puppet/modules"
    end
end
