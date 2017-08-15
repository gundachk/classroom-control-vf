class skeleton { 
file {'/etc/skel':
   ensure => directory,
   }
   
filr {'/etc/skel/.bashrc':
  ensure  => file,
  source  => 'puppet:///modules/skeleton/bashrc",
  }
