class yum::repo::vmware_tools(
  $esxi_version = '5.0',
  $el_version = 6
) {

  yum::repo { 'vmware-tools':
    desc            => "VMware Tools for EL${el_version} Linux \$releasever - \$basearch",
    baseurl         => "http://packages.vmware.com/tools/esx/${esxi_version}/rhel${el_version}/\$basearch/",
    enabled         => 1,
    gpgcheck        => 1,
    autokeyimport   => 'yes',
    gpgkey_name     => 'vmware',
    gpgkey          => 'http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub'
    }
}
