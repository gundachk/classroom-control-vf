class nginx {
  File {
    owner => 'nginx',
    group => 'nginx',
    mode  => '0644',
  }
  
  package { 'nginx':
    ensure => 'installed',
  }
  
  service { 'nginx':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['nginx'],
    subscribe  => [File['/etc/nginx/nginx.conf'], File['/etc/nginx/conf.d/nginx.conf']],
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => "puppet:///modules/${module_name}/nginx.conf",
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/conf.d/':
    ensure => directory,
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/conf.d/nginx.conf':
    ensure => file,
    source => "puppet:///modules/${module_name}/default.conf",
    require => Package['nginx'],
  }
}
