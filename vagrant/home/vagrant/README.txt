* Installing IntelliJ

To install IntelliJ, type the following at the prompt:

    $ sudo umake ide idea

* Installing Emacs

To install Emacs, type:

    $ sudo apt install emacs25

** Installing elpy - powerful Python mode for Emacs

Inside Emacs, type:

    M-x package-refresh-contents
    M-x package-install RET elpy RET

* Installing OpenCV

OpenCV is a -pain- to install. Therefore, we use a third-party installation
script to do it:

    $ cd ~/build/milq/scripts/bash
    $ bash install-opencv.sh

