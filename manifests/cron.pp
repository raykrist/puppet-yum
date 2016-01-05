# == Class: yum::cron
#
# This will only work on EL7 for now. yum-cron in el7 works like this:
# * service: yum-cron.service maintain the /var/lock/subsys/yum-cron file
# * cronjobs: if /var/lock/subsys/yum-cron is present run yum-cron
# * /etc/yum/yum-cron.conf: mange what, how, and report of yum-cron
# * /usr/sbin/yum-cron: run with options from /etc/yum-cron.conf
# 
# We remove package cron-daily and cron-hourly, and add our own cron.d/yum-cron
#
# === Example:
#   yum::cron {
#     update_cmd => security,
#     weekday => 3
#   }
#
# === Authors
#
# Raymond Kristiansen <raymond@uib.no>
#
class yum::cron(
  $ensure = present,
  $packages = 'yum-cron',
  $hour = '4',
  $weekday = '*', # every day
  $settings = hiera_hash('yum::cron::settings', {})
) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644'
  }

  package { $packages:
    ensure => installed
  }

  service { 'yum-cron':
    ensure => running
  }

  # Remove cronjobs from package
  file { ['/etc/cron.daily/0yum-daily.cron', '/etc/cron.hourly/0yum-hourly.cron']:
    content => template("${module_name}/cron_empty.erb"),
    require => Package[$packages],
    mode    => '0755'
  }

  file { '/etc/yum/yum-cron.conf':
    content => template("${module_name}/yum/yum-cron.conf.erb"),
    require => Package[$packages]
  }

  file { '/etc/cron.d/yum-cron':
    ensure => $ensure? { 'absent' => absent, default => file },
    content => template("${module_name}/cron.d/yum-cron.erb"),
  }

}
