#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export VAGRANT_LOG="vagrant.log"

Msg()
{
    echo "$@"
}

Error()
{
    echo "Error: $@" >&2
}

Cmd()
{
    cmd=$@

    $cmd || {
	Error "Cmd: '$cmd' failed with exit code $?."
	exit 1
    }
}

InstallDeb()
{
    for pkg in $*; do
	dpkg -s $pkg &> /dev/null || {
	    Msg " = Installing Debian package $pkg..."
	    apt-get install -y $pkg >>$VAGRANT_LOG || {
		Error "Installation of $pkg failed. Aborting."
		exit 1
	    }
	}
    done
}

AddUser()
{
    for user in $*; do
	grep -q "^$user:" || {
	    Msg "Adding user $user..."
	    useradd $user
	    for file in \
		/vagrant/home/$user/.bashrc \
		    /vagrant/home/$user/.emacs \
		    /vagrant/home/$user/.tmux.conf \
		; do
		Msg "  Copying $file..."
		cp -rp $file /home/$user
	    done
	    chown -R $user:$user /home/$user
	}
    done
}

EnableSwedishKeyboard()
{
    Msg "Enabling Swedish keyboard on the console... "
    grep -q "loadkeys" /etc/rc.local || {
	sed "s/^exit 0$/loadkeys se\nexit 0/g" -i /etc/rc.local
    }
    Cmd loadkeys se >/dev/null
}

CloneGitRepo()
{
    if [ $# -ne 2 ]; then
	Error "CloneGitRepo: Expected 2 args (dir URL), got '$*'."
	exit 1
    fi

    dir=$1
    url=$2
    
    if [ -d $dir ]; then
        return 0
    else
        MkDir $dir 750 vagrant vagrant
        Cmd git clone $url $dir
    fi
}

MkDir()
{
    if [ $# -ne 4 ]; then
	Error "MkDir: Expected 4 args, got '$*'."
	exit 1
    fi
    
    dir=$1
    mode=$2
    owner=$3
    group=$4

    if [ ! -e $dir ]; then
	Cmd mkdir $dir -pm $mode
    fi
    
    Cmd chown $owner:$group $dir 
}

ProvisionBase()
{
    Msg " ==== ProvisionBase ==== "
    Msg " = Setting time zone to Stockholm..."
    Cmd cp /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
    now=$(date)
    echo "Vagrant provisioning started $now" >$VAGRANT_LOG
    Msg " = Running apt-get update..."
    apt-get update >>$VAGRANT_LOG
    EnableSwedishKeyboard
    InstallDeb python3 python3-pip tmux git
    Msg " = Updating pip3..."
    pip3 install --upgrade setuptools pip

}
