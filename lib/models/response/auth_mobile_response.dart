class DataMobile {
  int? id;
  String? fullname;
  String? address;
  String? phone;
  int? isSubscribe;
  int? cgu;
  String? otp;

  DataMobile({
    required this.id,
    required this.fullname,
    required this.address,
    required this.phone,
    required this.isSubscribe,
    required this.cgu,
    this.otp,
  });

  DataMobile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    address = json['address'];
    phone = json['phone'];
    isSubscribe = json['isSubscribe'];
    cgu = json['cgu'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'fullname': fullname,
      'address': address,
      'phone': phone,
      'isSubscribe': isSubscribe,
      'cgu': cgu,
      'otp': otp,
    };
    return data;
  }
}

class AuthMobileResponse {
  int? status;
  DataMobile? data; // Can be either a String or a Data object
  String? token;
  String? message;

  AuthMobileResponse({
    required this.status,
    required this.data,
    required this.token,
    required this.message,
  });

  factory AuthMobileResponse.fromJson(Map<String, dynamic> json) {
    final int? status = json['status'];
    final dynamic data = json['data'];

    if (data is String) {
      return AuthMobileResponse(
        status: status,
        data: DataMobile(
          id: null,
          fullname: null,
          address: null,
          phone: null,
          isSubscribe: null,
          cgu: null,
          otp: null,
        ),
        token: json['token'],
        message: json['message'],
      );
    } else if (data is Map<String, dynamic>) {
      return AuthMobileResponse(
        status: status,
        data: DataMobile.fromJson(data),
        token: json['token'],
        message: json['message'],
      );
    } else {
      throw Exception('Invalid data format');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return {
      'status': this.status,
      'token': this.token,
      'message': this.message,
      ...data,
    };
  }
}
