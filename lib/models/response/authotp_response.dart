/* class AuthOtpResponse {
  bool status;
  List<Null> data;
  String token;
  String message;

  AuthOtpResponse({required this.status, required this.data, required this.token, required this.message});
  

  AuthOtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Null>();
      json['data'].forEach((v) {
        data.add(new Null.fromJson(v));
      });
    }
    token = json['token'];
    message = json['message'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}
 */

class AuthOtpResponse {
  int status;
  List<dynamic>? data;
  String token;
  String message;

  AuthOtpResponse({
    required this.status,
    this.data,
    required this.token,
    required this.message,
  });

  AuthOtpResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = json['data'] != null ? List<dynamic>.from(json['data']) : null,
        token = json['token'],
        message = json['message'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}