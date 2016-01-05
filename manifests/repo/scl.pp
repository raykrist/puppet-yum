
# == Define: yum::repo::scl
#
# Add a specific repo from https://www.softwarecollections.org
#
# This is only testet for EL7 and repo from rhscl!
# 
# Warning! There is no gpgkey check, the only security is SSL for transport
# 
# === Example:
#   yum::repo::scl { 'PHP 5.6.5'
#     repo => 'rh-php56',
#     vendor => 'rhscl'
#   }
#
# === Authors
#
# Raymond Kristiansen <raymond@uib.no>
#
define yum::repo::scl(
  $repo,
  $vendor = 'rhscl',
  $type = 'epel-7-x86_64'
) {

  ::yum::repo { "${vendor}-${repo}-${type}":
    desc            => "${name} - ${type}",
    baseurl         => "https://www.softwarecollections.org/repos/${vendor}/${repo}/${type}",
    enabled         => 1,
    gpgcheck        => 0,
  }

}
