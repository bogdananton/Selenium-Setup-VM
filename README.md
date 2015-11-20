
### Setup

#### Booting without a proxy

Run:

```bash
vagrant up
```

#### Booting with a proxy

Uncomment the lines in the Vagrantfile that refer to a proxy (and update the values to a proxy host and port of your choosing).

Install the proxy plugin (once), then boot

```bash
vagrant plugin install vagrant-proxyconf
vagrant up
```

### Access

#### Running self-assessment tests manually

```bash
vagrant ssh
cd phpunit-selenium-env
php phing-latest.phar selfTest
```

#### Via Virtualbox

Login with vagrant / vagrant, then "startx"
