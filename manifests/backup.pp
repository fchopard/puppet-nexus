# === Class: nexus::config
#
# Configure nexus.
#
# === Parameters
#
# NONE
#
# === Examples
#
# class{ 'nexus::config': }
#
# === Authors
#
# Tom McLaughlin <tmclaughlin@hubspot.com>
#
# === Copyright
#
# Copyright 2013 Hubspot
#
class nexus::backup(
  $nexus_root,
  $nexus_work,
  $nexus_backup_target_dir,
  $nexus_backup_includes_file,
  ) inherits nexus::params {

  $nexus_backup_script_file = "$nexus_root/nexus-backup.sh"
  $nexus_backup_includes = "$nexus_root/nexus-backup-includes.list"

  file { $nexus_backup_script_file:
    ensure  => present,
    owner   => $nexus_user,
    group   => $nexus_group,
    mode    => 744,
    content => template('nexus/nexus-backup.sh.erb'),
  }
  
  file { $nexus_backup_includes:
    ensure  => present,
    owner   => $nexus_user,
    group   => $nexus_group,
    content => $nexus_backup_includes_file,
  }

  cron { 'nexus-backup':
    command => $nexus_backup_script_file,
    user    => $nexus_user,
    hour    => 2,
    minute  => 15,
  }
}
