class yum::repo::pgdg_rhel_91() {

  yum::repo { 'pgdg-rhel-91':
    desc            => 'PostgreSQL 9.1 $releasever - $basearch',
    baseurl         => 'http://yum.postgresql.org/9.1/redhat/rhel-$releasever-$basearch',
    enabled         => 1,
    gpgcheck        => 1,
    gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-91',
  }
  
  # Add gpgkey file
  yum::gpgkey { 'RPM-GPG-KEY-PGDG-91':
    source => 'puppet:///modules/yum/RPM-GPG-KEY-PGDG-91',
  }

  if $::operatingsystem == 'RedHat' {
    augeas { "rhnplugin_conf":
      context => "/files/etc/yum/pluginconf.d/rhnplugin.conf/main",
      changes => [
        "set exclude postgresql*",
      ],
    }
  }
}