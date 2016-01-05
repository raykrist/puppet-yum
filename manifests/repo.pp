# == Define: yum repo
#
# Add a new yum repo file
#
# === Parameters
#
# Document parameters here
#
# [*namevar*]
#   Repo name. Mandatory. Exampled epel, foreman
#
# [*baseurl*]
#   Url for the repo
#
# [*mirrorlist*]
#   URL for the mirror list
# 
# [*enabled*]
#   Unless this is 1 or true, we will not be able to use the repo without 
#   --enablerepo=*namevar* on the command line for yum.
#
# [*gpgkey*]
#   This should be an url for the gpgkey used for this repo. If this is present
#   and autokeyimport is 'yes' we will try to import the key with rpm --import
#
# [*autokeyimport*]
#   Import the key with rpm --import
#
# [*gpgkey_name*]
#   This is only needed if autokeyimport = 'yes'. To avoid import on every
#   puppet run this should be set to a matching name from the output of
#   rpm -q --qf \"%{NAME}-%{VERSION}-%{RELEASE} \n %{SUMMARY} \n\" gpg-pubkey
#
# === Examples
#
# Provide some examples on how to use this type:
#
#   yum::repo { 'foreman':
#     desc => 'Foreman stable repository',
#     baseurl => 'http://yum.theforeman.org/releases/1.0/el6/$basearch',
#     enabled => 1
#   }
#
# === Authors
#
# Raymond Kristiansen <st02221@uib.no>
#
define yum::repo(
  $ensure = present,
  $desc = '',
  $baseurl = false,
  $mirrorlist = false,
  $enabled = 0,
  $gpgcheck = 0,
  $gpgkey = false,
  $priority = 99,
  $autokeyimport = 'no',
  $gpgkey_name = false,
  $exclude = false,
  $includepkgs = undef
  ){

  # Ensure require puppet version 3.5+
  yumrepo { $name:
#    ensure => $ensure,
    descr => $desc,
    baseurl => $baseurl,
    mirrorlist => $mirrorlist,
    enabled => $enabled,
    gpgcheck => $gpgcheck,
    gpgkey => $gpgkey,
#    failovermethod => $failovermethod,
#    priority => $priority,
    exclude => $exclude,
    includepkgs => $includepkgs,
  }

  if $autokeyimport == 'yes' and $gpgkey {
    exec { "rpmkey_add_${name}":
      command => "rpm --import ${gpgkey}",
      path => '/sbin:/bin:/usr/sbin:/usr/bin',
      unless => "rpm -q --qf \"%{NAME}-%{VERSION}-%{RELEASE} \n %{SUMMARY} \n\" gpg-pubkey | grep -i '${gpgkey_name}' 2>/dev/null"
    }
  } 
}
