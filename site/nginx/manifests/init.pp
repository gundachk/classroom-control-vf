class nginx {
  
  # Need to install the software
  package { 'nginx':
    ensure => present,
  }


  # Setting some defaults here so I don't have to repeat myself
  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
  }

  # Building the directories first
  file { [ '/var/www', '/etc/nginx/conf.d' ]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0775',
  }

  # Require tells Puppet that the package comes first before the type.
  # Notify tells Puppet that if this resource changes, it needs to reload the service in this case.
  #
  file { '/etc/nginx/nginx.conf':
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/conf.d/default.conf':
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }
}


