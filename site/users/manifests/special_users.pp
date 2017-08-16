class users::special_users {
  
  
users::managed_user {'jose':}
users::managed_user {'alice':
  group => 'wheel',
}
users::managed_user {'chen':
  group => 'chen',
}
