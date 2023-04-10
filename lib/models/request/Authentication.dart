

class LoginRequest {
  late final String email;
  late final String password;

  LoginRequest(this.email, this.password);

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }
}
