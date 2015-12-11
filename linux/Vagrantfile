Vagrant.configure(2) do |config|
    # @note shouldn't this be passed through by the vagrant_proxyconfig plugin?
    vagrant_startx = "#{ENV['vagrant_startx']}"

    config.vm.box = "ubuntu/vivid64"

    # @todo temporary: disable update, don-t install chrome, use chromium-browser instead
    config.vm.box_check_update = false

    # @todo set fixed http_proxy / https_proxy in ~/.bashrc
    config.vm.provision :shell, path: "bootstrap.sh"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "2"
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        vb.customize ["modifyvm", :id, "--pae", "on"]
        vb.customize ["modifyvm", :id, "--chipset", "ich9"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end
end
