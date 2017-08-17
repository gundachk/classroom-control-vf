class nginx::params {
case $facts['os']['family'] {
'redhat','debian' : {
$package = 'nginx'
$owner = 'root'
$group = 'root'
$docroot = '/var/www'
$confdir = '/etc/nginx'
$logdir = '/var/log/nginx'
}
'windows' : {
$package = 'nginx-service'
$owner = 'Administrator'
$group = 'Administrators'
$docroot = 'C:/ProgramData/nginx/html'
$confdir = 'C:/ProgramData/nginx'
$logdir = 'C:/ProgramData/nginx/logs'
}
default : {
fail("Module ${module_name} is not supported on ${facts['os']['family']}")
}
}
$user = $facts['os']['family'] ? {
'redhat' => 'nginx',
'debian' => 'www-data',
'windows' => 'nobody',
}
$port = '80'
}
class nginx (
$package = $nginx::params::package,
$owner = $nginx::params::owner,
$group = $nginx::params::group,
$docroot = $nginx::params::docroot,
$confdir = $nginx::params::confdir,
$logdir = $nginx::params::logdir,
$user = $nginx::params::user,
$port = $nginx::params::port
) inherits nginx::params {
File {
owner => $owner,
group => $group,
mode => '0664',
}
package { $package:
ensure => present,
}
file { [ $docroot, "${confdir}/conf.d" ]:
ensure => directory,
}
file { "${docroot}/index.html":
ensure => file,
source => 'puppet:///modules/nginx/index.html',
}
file { "${confdir}/nginx.conf":
ensure => file,
content => epp('nginx/nginx.conf.epp',
{
user => $user,
confdir => $confdir,
logdir => $logdir,
}),
notify => Service['nginx'],
}
file { "${confdir}/conf.d/default.conf":
ensure => file,
content => epp('nginx/default.conf.epp',
{
port => $port,
docroot => $docroot,
}),
notify => Service['nginx'],
}
service { 'nginx':
ensure => running,
enable => true,
}
}
