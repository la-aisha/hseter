class AuthOtpRequest {
  AuthOtpRequest({
    required this.oldOtp,
    required this.newOtp,

  });

  String? oldOtp;
  String? newOtp;


  factory AuthOtpRequest.fromJson(Map<String, dynamic> json) {
    return AuthOtpRequest(
      oldOtp: json["oldOtp"],
      newOtp: json["newOtp"],

    );
  }

  Map<String, dynamic> toJson() => {
        "oldOtp": oldOtp,
        "newOtp": newOtp,
      };
}
