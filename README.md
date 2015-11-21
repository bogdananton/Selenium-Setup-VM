# Selenium PHPUnit Environment Setup with Vagrant

#### Install

1. Download [Vagrant](https://www.vagrantup.com/downloads.html) (Windows, Linux, Mac)
1. Download [Virtual Box](https://www.virtualbox.org/wiki/Downloads) (Windows, Linux, Mac)
1. `git clone https://github.com/bogdananton/phpunit-selenium-vagrant.git`
1. `cd phpunit-selenium-vagrant`
    1. if the environment variable http_proxy is set, run `vagrant plugin install vagrant-proxyconf`.
1. `vagrant up`
1. Wait until the box is downloaded and installed. This might take a while.
1. In the end the self check test suite will run for `phpunit-selenium-vagrant`

To repeat the Selenium check-up manually, follow these steps:

1. ssh to your vagrant box `127.0.0.1:2222`
1. `startx`
1. `cd phpunit-selenium-vagrant`
1. `php phing-latest.phar`
