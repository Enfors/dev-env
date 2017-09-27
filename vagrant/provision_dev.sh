!/usr/bin/env bash

. /vagrant/provision_base.sh

ProvisionDev()
{
    Msg " ==== ProvisionDev ==== "
    CloneGitRepo /home/vagrant/devel/elisp/enfors-lib/ \
		 https://github.com/enfors/enfors-lib
    ConfigureUser vagrant
    InstallEmacs25
    #FixDB
    #InstallDeb xfce4
    InstallPythonLibs
    InstallX
    InstallIntelliJ
}

FixDB()
{
    Msg " == Fixing database..."
    Cmd /usr/share/debconf/fix_db.pl
}
InstallEmacs25()
{
    Msg " == Installing emacs25..."
    add-apt-repository -y ppa:kelleyk/emacs >>$VAGRANT_LOG
    apt-get update >>$VAGRANT_LOG
    #InstallDeb emacs25
}

InstallPythonLibs()
{
    Msg " == Installing Python libraries..."
    # As per https://askubuntu.com/questions/538905/cannot-install-scikit-learn-in-python-3-4-in-ubuntu-14-04:

    InstallDeb build-essential python3-dev python3-setuptools python3-numpy \
	python3-scipy python3-pip libatlas-dev libatlas3gf-base \
	python3-matplotlib python3-pandas
    Msg " = Installing pip3 packages scikit-learn, jupyter and seaborn..."
    pip3 install --upgrade scikit-learn jupyter seaborn >>$VAGRANT_LOG

    update-alternatives --set libblas.so.3 \
        /usr/lib/atlas-base/atlas/libblas.so.3
    update-alternatives --set liblapack.so.3 \
        /usr/lib/atlas-base/atlas/liblapack.so.3
}

InstallX()
{
    Msg " == Installing X Window System..."
    InstallDeb xfce4 firefox
}

InstallIntelliJ()
{
    Msg " == Preparing for installation of IntelliJ IDE..."
    Msg " = Adding repository..."
    add-apt-repository ppa:ubuntu-desktop/ubuntu-make >>$VAGRANT_LOG
    apt-get update >>$VAGRANT_LOG
    unset SUDO_UID
    unset SUDO_GID
    InstallDeb ubuntu-make
    #Msg " = Installing IntelliJ package..."
    #echo | umake ide idea >>$VAGRANT_LOG
}

ConfigureUser()
{
    for user in $*; do
	Msg " == Configuring user $user..."
    
	SetXFCEKeyboard $user

	for file in \
	    /vagrant/home/$user/.bashrc \
		/vagrant/home/$user/.emacs \
		/vagrant/home/$user/.gitconfig \
		/vagrant/home/$user/.tmux.conf \
		/vagrant/home/$user/.Xresources \
		/vagrant/home/$user/README.txt
	do
	    Msg "  Copying $file"
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

    Msg "  Enabling Swedish keyboard in xfce..."
    
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
    Msg " ==== Provisioning completed. ==== "
}

Main
