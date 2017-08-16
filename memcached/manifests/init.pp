file { '/etc/sysconfig/memcached':

ensure => file,

owner => 'root',

group => 'root',

mode => '0644',

source => 'puppet:///modules/ntp/ntp.conf',

require => Package['ntp'],

}

package { 'ntp':

ensure => present,

}

service { 'ntpd':

ensure => running,

enable => true,

subscribe => File['/etc/ntp.conf'],

}
