import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:terappmobile/configs/config.dart';

class UpdateUserInfosProvider extends ChangeNotifier {
  String fullname = "aze";
  String adress = "aze";
  String phone = "azer";
   int id=1;

  Map<String, dynamic> updateResponse = {};

  Future<Map<String, dynamic>> updateUser() async {
    final Uri apiUrl = Uri.parse("${Config.apiUrl}${Config.updateUser}");
final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> requestData = {
      "id": id,
      "fullname": fullname,
      "adress": adress,
      "phone": phone,
    };
    try {
      final http.Response response = await http.put(
        apiUrl,
        body: jsonEncode(requestData),
        headers: headers
      );

      if (response.statusCode == 201) {
        updateResponse = jsonDecode(response.body);
        print("prenom $fullname");
        print("nom $adress");
        print("adresse $phone");

        notifyListeners();
        return updateResponse;
      } else {
        throw Exception('Failed to update user 1: ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('Failed to update user 2: $error');
    }
  }
}
