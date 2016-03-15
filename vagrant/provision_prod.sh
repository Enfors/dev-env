#!/usr/bin/env bash

. /vagrant/provision_base.sh

ProvisionProd()
{
    echo &>/dev/null
}

Main()
{
    ProvisionBase
    ProvisionProd
}

Main
