# Selenium PHPUnit Environment Setup with Vagrant

#### Install

1. Download [Vagrant](https://www.vagrantup.com/downloads.html) (Windows, Linux, Mac)
2. Download [Virtual Box](https://www.virtualbox.org/wiki/Downloads) (Windows, Linux, Mac)
3. `git clone https://github.com/bogdananton/phpunit-selenium-vagrant.git`
4. `cd phpunit-selenium-vagrant`
5. `vagrant up`
6. Wait until the box is downloaded and installed. This might take a while.
7. In the end the self check test suite will run for `phpunit-selenium-vagrant`

To repeat the Selenium check-up manually, follow these steps:

1. ssh to your vagrant box
2. `cd phpunit-selenium-vagrant`
3. `php phing-latest.phar`
