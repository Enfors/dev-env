#!/usr/bin/env bash

. /vagrant/provision_base.sh

ProvisionProd()
{
    echo &>/dev/null
    SetHostname prod
}

Main()
{
    ProvisionBase
    ProvisionProd
}

Main
