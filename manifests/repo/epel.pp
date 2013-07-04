class yum::repo::epel() {

  yum::repo { 'epel':
    desc            => 'Extra Packages for Enterprise Linux 6 - $basearch',
    mirrorlist      => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
    enabled         => 1,
    gpgcheck        => 1,
    gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6'
  }

  yum::repo { 'epel-testing':
    desc            => 'Extra Packages for Enterprise Linux 6 - Testing - $basearch',
    mirrorlist      => 'https://mirrors.fedoraproject.org/metalink?repo=testing-epel6&arch=$basearch',
    enabled         => 0,
    gpgcheck        => 1,
    gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6'
  }

  # Add gpgkey file
  yum::gpgkey { 'RPM-GPG-KEY-EPEL-6':
    source => 'puppet:///modules/yum/RPM-GPG-KEY-EPEL-6',
  }

}