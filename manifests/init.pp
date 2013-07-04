# == Class: yum
#
# Simple yum module. We should add more to this later.
#
# Defines: 
#   yum::repo - add a new repo
#   yum::gpgkey - add a new gpgkey to /etc/pki/rpm-gpg
#
# Example repos:
# We have some examples for simple repos under repo/
#   yum::repo::pgdg-rhel-91 - add postgresql 9.1 RHEL repo with gpgkeys
#   yum::repo::epel - add EPEL repo for EL6 with pgpkeys
#
# === Parameters
#
# Document parameters here.
#
# [*purge_yumreposd*]
#   If set to true we remove all unmanaged repos from /etc/yum.repos.d
#   Default: false
#
# === Examples
#
#  class { 'yum': }
#
# === Authors
#
# Raymond Kristiansen <st02221@uib.no>
#
class yum(
  $purge_yumreposd = false
)  {

  file { "/etc/yum.repos.d":
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => "0644",
    purge => $purge_yumreposd,
    recurse => $purge_yumreposd, 
  }
  
}