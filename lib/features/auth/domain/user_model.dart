class UserLogin {
  final String id;
  final String email;

  const UserLogin({required this.id, required this.email});

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(id: json['id'].toString(), email: json['email'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email};
  }
}

// pub status: u16,
//     pub state: bool,
//     pub msg: String,
//     pub token: String,
class LoginResponse {
  final int status;
  final bool state;
  final String msg;
  final String token;
  final String role;

  LoginResponse({
    required this.status,
    required this.state,
    required this.msg,
    required this.token,
    required this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"],
      state: json["state"],
      msg: json["msg"],
      token: json["token"],
      role: json["role"],
    );
  }
}

class UserRegister {
  final String userName;
  final String password;
  final String email;

  const UserRegister({
    required this.userName,
    required this.password,
    required this.email,
  });
}

class UserProfile {
  final String userUame;
  final String email;
  final String joinDate;

  UserProfile({
    required this.userUame,
    required this.email,
    required this.joinDate,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userUame: json["user_name"],
      email: json["email"],
      joinDate: json["join_date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {'user_name': userUame, 'email': email, 'join_date': joinDate};
  }
}
