class yum::repo::epel(
  $exclude = false,
  $baseurl = undef
) {

  $releasever = $::operatingsystemmajrelease

  yum::repo { 'epel':
    desc          => "Extra Packages for Enterprise Linux ${$releasever} - \$basearch",
    mirrorlist    => empty($baseurl)? {
      true    => "https://mirrors.fedoraproject.org/metalink?repo=epel-${$releasever}&arch=\$basearch",
      default => absent },
    baseurl       => empty($baseurl)? {
      true    => absent,
      default => $baseurl },
    enabled       => 1,
    gpgcheck      => 1,
    exclude       => $exclude,
    autokeyimport => 'yes',
    gpgkey_name   => 'epel@fedoraproject.org',
    gpgkey        => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${$releasever}"
  }

  yum::repo { 'epel-testing':
    desc       => "Extra Packages for Enterprise Linux  ${$releasever}- Testing - \$basearch",
    mirrorlist => "https://mirrors.fedoraproject.org/metalink?repo=testing-epel${$releasever}&arch=\$basearch",
    enabled    => 0,
    gpgcheck   => 1,
    gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${$releasever}"
  }

  # Add gpgkey file
  yum::gpgkey { "RPM-GPG-KEY-EPEL-${$releasever}":
    source => "puppet:///modules/yum/RPM-GPG-KEY-EPEL-${$releasever}",
    before => Yum::Repo['epel']
  }

}
