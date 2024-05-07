class AuthRegisterResponse {
  int? status;
  Data? data;
  String? token;
  String? message;

  AuthRegisterResponse({
    required this.status,
    required this.data,
    required this.token,
    required this.message,
  });

  // Factory method to create an instance from JSON data
  factory AuthRegisterResponse.fromJson(Map<String, dynamic> json) {
    return AuthRegisterResponse(
      status: json['status'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      token: json['token'],
      message: json['message'],
    );
  }

  // Method to convert the object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'status': this.status,
      'data': this.data != null ? this.data!.toJson() : null,
      'token': this.token,
      'message': this.message,
    };
  }
}

class Data {
  int? id;
  String? fullname;
  String? otp;
  String? adress;
  String? phone;
  bool? cgu;
  bool? isSubscribe;

  Data({
    required this.id,
    required this.fullname,
    required this.otp,
    required this.adress,
    required this.phone,
    required this.cgu,
    required this.isSubscribe,
  });

  // Factory method to create an instance from JSON data
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
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
      'id': this.id,
      'fullname': this.fullname,
      'otp': this.otp,
      'adress': this.adress,
      'phone': this.phone,
      'cgu': this.cgu,
      'isSubscribe': this.isSubscribe,
    };
  }
}
