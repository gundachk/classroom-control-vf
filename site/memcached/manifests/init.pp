class memcached {
  package { 'memcached':
    ensure => present,
    }
    file { '/etc/sysconfig/memcached':
      ensure  => file,
      ownder  => 'root',
      group   => 'root',
      mode    => '0664',
      source  => 'puppet:///modules/memcachedmemcached',
      require => Package['memcached'],
    }
    
    service { 'memcached':
      ensure    => running, 
      enable    => true,
      subscribe => File['/etc/sysconfig/memcached'],
    }
  }
      
    
  
