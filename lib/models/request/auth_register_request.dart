class AuthRegisterRequest {
  String? fullname;
  String? otp;
  String? adress;
  String? phone;
  bool? cgu;
  bool? isSubscribe;

  AuthRegisterRequest({
    required this.fullname,
    required this.otp,
    required this.adress,
    required this.phone,
    required this.cgu,
    required this.isSubscribe,
  });

  // Factory method to create an instance from JSON data
  factory AuthRegisterRequest.fromJson(Map<String, dynamic> json) {
    return AuthRegisterRequest(
      fullname: json['fullname'],
      otp: json['otp'],
      adress: json['adress'],
      phone: json['phone'],
      cgu: json['cgu'],
      isSubscribe: json['isSubscribe'],
    );
  }

  // Method to convert the object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'fullname': this.fullname,
      'otp': this.otp,
      'adress': this.adress,
      'phone': this.phone,
      'cgu': this.cgu,
      'isSubscribe': this.isSubscribe,
    };
  }
}
