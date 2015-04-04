class yum::repo::puppetlabs(
  $enabled = 1,
  $el_version = 6,
) {

  $releasever = $::operatingsystemmajrelease

  yum::repo { 'puppetlabs-products':
    desc            => "Puppet Labs Products El ${$releasever} - \$basearch",
    baseurl         => "http://yum.puppetlabs.com/el/${$releasever}/products/\$basearch",
    enabled         => $enabled,
    gpgcheck        => 1,
    gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'
  }

  yum::repo { 'puppetlabs-deps':
    desc            => "Puppet Labs Dependencies El ${$releasever} - \$basearch",
    baseurl         => "http://yum.puppetlabs.com/el/${$releasever}/dependencies/\$basearch",
    enabled         => $enabled,
    gpgcheck        => 1,
    gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'
  }

  # Add gpgkey file
  yum::gpgkey { 'RPM-GPG-KEY-puppetlabs':
    source => 'puppet:///modules/yum/RPM-GPG-KEY-puppetlabs',
  }

}
