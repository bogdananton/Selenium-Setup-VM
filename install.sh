
export vagrantInstalled=`vagrant -v`
export virtualboxInstalled=`virtualbox -v`

if ! $vagrantInstalled && $virtualboxInstalled ; then
    # failed, some components are missing

    distroId=`cat /etc/*-release | grep "ID="`
    echo "Found distribution ID: ${distroId:3}" # @todo check if the pattern is ok

    if [ "${distroId:3}" == "antergos" ]; then
        # will (re)install packages after syncronization and not ask for confirmation. Warning: this could break your virtualbox install.
        sudo pacman -S --noconfirm vagrant virtualbox virtualbox-host-dkms net-tools

    elif [ "${distroId:3}" == "Ubuntu" ]; then
        # fixme untested yet (lowercase/uppercase)
        sudo apt-get -y install vagrant virtualbox virtualbox-host-dkms net-tools
    else
        echo "Error: Install vagrant and virtualbox manually or add a command in this install.sh file."
        exit
    fi
fi

vagrant plugin install vagrant-proxyconf
vagrant up
