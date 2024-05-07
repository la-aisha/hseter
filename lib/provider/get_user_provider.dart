import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:terappmobile/configs/config.dart';

class GetUserProvider extends ChangeNotifier {
  late int id;

  Map<String, dynamic> getUserResponse = {};

  Future<Map<String, dynamic>> fetchUser() async {
    final Uri apiUrl = Uri.parse("${Config.apiUrl}${Config.getUser}$id");
    try {
      final http.Response response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        getUserResponse = jsonDecode(response.body);
        notifyListeners();
        print(getUserResponse);
        return getUserResponse;
      } else {
        throw Exception('Failed to register: ${response.reasonPhrase}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Failed to connect to the server: $e');
    } on TimeoutException catch (e) {
      throw Exception('Connection timed out: $e');
    } on FormatException catch (e) {
      throw Exception('Invalid server response: $e');
    } catch (error) {
      throw Exception('Unknown error occurred: $error');
    }
  }
}
