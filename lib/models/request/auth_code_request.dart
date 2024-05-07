class AuthMobileRequest {
  AuthMobileRequest({
    required this.phone,
  });
  String? phone;
  factory AuthMobileRequest.fromJson(Map<String, dynamic> json) {
    return AuthMobileRequest(
      phone: json["phone"],
    );
  }
  Map<String, dynamic> toJson() => {
    "phone": phone,
  };
}
