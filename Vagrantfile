Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/vivid64"

    # Create a forwarded port mapping: accessing "localhost:7001" will access port 80 on the guest machine.
    config.vm.network "forwarded_port", guest: 80, host: 7001   # Apache
    config.vm.network "forwarded_port", guest: 8321, host: 7002 # Selenium server

    # Create a private network, which allows host-only access to the machine using a specific IP.
    config.vm.network "private_network", ip: "192.168.33.10"

    # (optional) Share host folders with the guest machine.
    # - set up a folder to be served via the guest machine's apache2 web server
    config.vm.synced_folder "shared/website/", "/var/www/html"
    # - set up a cachegrind dump folder
    config.vm.synced_folder "shared/cachegrind/", "/home/vagrant/cachegrind", disabled: true

    # VirtualBox config
    # config.vm.provider "virtualbox" do |vb|
    #   vb.gui = true      # Display the VirtualBox GUI when booting the machine
    #   vb.memory = "1024" # Customize the amount of memory on the VM:
    # end

    config.vm.provision "shell", inline: <<-SHELL
        # Google Chrome sources
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

        sudo apt-get update
        sudo mkdir /home/vagrant/cachegrind

        # install dependencies
        sudo apt-get install -y git curl default-jre openjdk-7-jre google-chrome-stable firefox phantomjs apache2 php5 php5-memcache php5-curl php5-mysql
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

        sudo chown vagrant:vagrant -R build/logs

        # start selenium server
        php phing-latest.phar startSelenium &

    SHELL

    # config.proxy.http     = "http://proxy.company.com:8888"
    # config.proxy.https    = "http://proxy.company.com:8888"
    # config.proxy.no_proxy = "localhost,127.0.0.1,*.local,192.168.33.10"
end
