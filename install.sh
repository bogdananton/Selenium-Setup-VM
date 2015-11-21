#
# Warning: this could break your virtualbox install.
#
# After upgrading Virtualbox from 5.0.4 to 5.0.8, a fatal error was displayed at launch (Virtual COMM object).
# Solved by downgrading Virtualbox and its modules to 5.0.4
#
#  sudo su
#  ls /var/cache/pacman/pkg | grep virtualbox
#  pacman -Uy /var/cache/pacman/pkg/virtualbox-5.0.4-1-x86_64.pkg.tar.xz /var/cache/pacman/pkg/virtualbox-guest-iso-5.0.4-1-any.pkg.tar.xz /var/cache/pacman/pkg/virtualbox-host-dkms-5.0.4-1-x86_64.pkg.tar.xz /var/cache/pacman/pkg/virtualbox-host-modules-5.0.4-2-x86_64.pkg.tar.xz
#  dkms install vboxhost/5.0.4
#  dkms autoinstall
#

export vagrantInstalled=`vagrant -v`
export virtualboxInstalled=`virtualbox -v`

if ! $vagrantInstalled && $virtualboxInstalled ; then
    # failed, some components are missing

    distroId=`cat /etc/*-release | grep "ID="`
    echo "Found distribution ID: ${distroId:3}" # @todo check if the pattern is ok

    if [ "${distroId:3}" == "antergos" ]; then
        # will (re)install packages after syncronization and not ask for confirmation.
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
