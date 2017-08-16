class users::special_users {
  users::managed_user { 'joe': }
  users::managed_user { 'alice':
  group => 'wheel',
  }
  users::managed_user { 'aaron':
    group => 'staff',
  }
  group { 'staff':
    ensure => present,
  }
}
