#!/usr/bin/env bash

. /vagrant/provision_base.sh

ProvisionDev()
{
    echo " ==== ProvisionDev ==== "
    FixDB
    CloneGitRepo /home/vagrant/devel/elisp/enfors-lib/ \
		 https://github.com/enfors/enfors-lib
    ConfigureUser vagrant
    InstallEmacs25
}

FixDB()
{
    Cmd /usr/share/debconf/fix_db.pl
}
InstallEmacs25()
{
    echo "Installing emacs25..."
    sudo add-apt-repository -y ppa:kelleyk/emacs >/dev/null
    sudo apt-get update >/dev/null
    sudo apt-get install emacs25 >/dev/null
}

ConfigureUser()
{
    for user in $*; do
	echo "Configuring user $user..."
    
	SetXFCEKeyboard $user

	for file in \
	    /vagrant/home/$user/.bashrc \
		/vagrant/home/$user/.emacs \
		/vagrant/home/$user/.tmux.conf \
		/vagrant/home/$user/.Xresources
	do
	    echo "  Copying $file"
	    Cmd cp -rp $file /home/$user
	done
	Cmd chown -R $user:$user /home/$user
    done
}

SetXFCEKeyboard()
{
    user=$1
    base_dir=/home/$user
    target_dir=$base_dir/.config/xfce4/xfconf/xfce-perchannel-xml
    target_file=$target_dir/keyboard-layout.xml

    echo "  Enabling Swedish keyboard in xfce..."
    
    MkDir $base_dir/.config                                  700 $user $user
    MkDir $base_dir/.config/xfce4                            775 $user $user
    MkDir $base_dir/.config/xfce4/xfconf                     775 $user $user
    MkDir $base_dir/.config/xfce4/xfconf/xfce-perchannel-xml 700 $user $user

    Cmd cp /vagrant/keyboard-layout.xml $target_file
    Cmd chown $user:$user $target_file
}

Main()
{
    ProvisionBase
    ProvisionDev
    echo "Provisioning completed."
}
# pip3 install --user numpy scipy matplotlib ipython jupyter pandas sympy nose seaborn sklearn
Main
