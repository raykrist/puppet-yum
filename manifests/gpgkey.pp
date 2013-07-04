define yum::gpgkey(
  $source,
  $pki_path = "/etc/pki/rpm-gpg"
  ) {

  file { $name:
    path => "${pki_path}/${$name}",
    owner => 'root',
    group => 'root',
    mode => '0644',
    ensure => present,
    source => $source
  }    
}