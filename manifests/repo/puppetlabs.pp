class yum::repo::puppetlabs(
  $enabled = 1,
  $el_version = 6,
) {

  yum::repo { 'puppetlabs-products':
    desc            => "Puppet Labs Products El ${el_version} - \$basearch",
    baseurl         => "http://yum.puppetlabs.com/el/${el_version}/products/\$basearch",
    enabled         => $enabled,
    gpgcheck        => 1,
    gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'
  }

  yum::repo { 'puppetlabs-deps':
    desc            => "Puppet Labs Dependencies El ${el_version} - \$basearch",
    baseurl         => "http://yum.puppetlabs.com/el/${el_version}/dependencies/\$basearch",
    enabled         => $enabled,
    gpgcheck        => 1,
    gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'
  }

  # Add gpgkey file
  yum::gpgkey { 'RPM-GPG-KEY-puppetlabs':
    source => 'puppet:///modules/yum/RPM-GPG-KEY-puppetlabs',
  }

}
