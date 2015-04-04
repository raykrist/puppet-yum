class yum::repo::centos_base(
  $exclude = false
) {

  $releasever = $::operatingsystemmajrelease

  yum::repo { 'base':
    desc            => "CentOS-${releasever} - Base",
    mirrorlist      => "http://mirrorlist.centos.org/?release=${releasever}&arch=\$basearch&repo=os",
    #baseurl         => "http://mirror.centos.org/centos/${releasever}/os/\$basearch/",
    enabled         => 1,
    gpgcheck        => 1,
    autokeyimport   => 'yes',
    exclude         => $exclude,
    gpgkey_name     => 'epel@fedoraproject.org',
    gpgkey          => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${$releasever}"
  }

  yum::repo { 'updates':
    desc            => "CentOS-${releasever} - Updates",
    mirrorlist      => "http://mirrorlist.centos.org/?release=${releasever}&arch=\$basearch&repo=updates",
    #baseurl         => "http://mirror.centos.org/centos/${releasever}/updates/\$basearch/",
    enabled         => 1,
    gpgcheck        => 1,
    autokeyimport   => 'yes',
    exclude         => $exclude,
    gpgkey_name     => 'epel@fedoraproject.org',
    gpgkey          => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${$releasever}"
  }

  # Add gpgkey file
  yum::gpgkey { "RPM-GPG-KEY-CentOS-${$releasever}":
    source => "puppet:///modules/yum/RPM-GPG-KEY-CentOS-${$releasever}",
    before => Yum::Repo['epel']
  }



}