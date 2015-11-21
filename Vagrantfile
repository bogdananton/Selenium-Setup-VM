Vagrant.configure(2) do |config|
    http_proxy = "#{ENV['http_proxy']}"

    unless "#{http_proxy}" == ""
        p "Set machine proxy to #{http_proxy}"
        config.proxy.http = #{http_proxy}
        config.proxy.https = #{http_proxy}
        config.proxy.no_proxy = "localhost,127.0.0.1,.local"
    end

    config.vm.box = "ubuntu/vivid64"
    config.vm.box_check_update = false
    config.vm.network "forwarded_port", guest: 80, host: 83

    config.vm.provision "shell", inline: <<-SHELL
        # @todo check unix/win lower/uppercase for http/https proxy env setting
        if ! [ -z #{http_proxy} ]; then
            echo "Setting environment variables http_proxy and https_proxy to #{http_proxy}"
            export http_proxy=http_proxy
            export https_proxy=https_proxy
        fi

        # Google Chrome sources
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

        # Sync Ubuntu packages
        sudo apt-get update

        # Install dependencies
        sudo apt-get install -y git curl default-jre openjdk-7-jre google-chrome-stable firefox apache2 php5 php5-memcache php5-curl php5-mysql xfce4

        # Assure that SSH Agent is running (used to add keys to the known_hosts in ~/.ssh)
        eval `ssh-agent -s`

        # run virtual X server
        sudo apt-get install -y xvfb
        export DISPLAY=:99.0
        /sbin/start-stop-daemon --start --quiet --pidfile /tmp/custom_xvfb_99.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -ac -screen 0 1280x1024x16

        # get phpunit-selenium-env repo
        git clone https://github.com/bogdananton/phpunit-selenium-env
        cd phpunit-selenium-env

        # prepare build
        wget http://www.phing.info/get/phing-latest.phar
        chmod +x phing-latest.phar

        # run build and tests
        php phing-latest.phar

        # Reset ownership of phpunit-selenium-vagrant folder to the vagrant user.
        sudo chown vagrant:vagrant -R ./

    SHELL

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

    # raise(Exception, "-> stop <-")
end
