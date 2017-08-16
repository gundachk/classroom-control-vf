class memcached {
  package { 'memcached':
    ensure => installed,
  }
  
  service { 'memcached':
    ensure => running,
    enable => true,
    require => Package['memcached'],
  }
  
  file { '/etc/sysconfig/memcached':
    ensure => file,
    source => "puppet:///modules/${module_name}/memcached",
    require => Package['memcached'],
    notify => Service['memcached'],
  }
}
