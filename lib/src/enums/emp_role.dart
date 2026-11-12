enum AuthRole {
  admin,
  owner,
  employee,
}

AuthRole parseRole(String role) {
  switch (role) {
    case 'admin':
      return AuthRole.admin;

    case 'owner':
      return AuthRole.owner;

    case 'employee':
      return AuthRole.employee;

    default:
      throw Exception('Unknown role');
  }
}