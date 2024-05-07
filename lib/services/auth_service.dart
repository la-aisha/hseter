import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:terappmobile/configs/config.dart';
import 'package:terappmobile/models/request/auth_code_request.dart';
import 'package:terappmobile/models/request/auth_register_request.dart';
import 'package:terappmobile/models/request/authotp_request.dart';
import 'package:terappmobile/models/response/auth_mobile_response.dart';
import 'package:terappmobile/models/response/auth_register_response.dart';
import 'package:terappmobile/models/response/authotp_response.dart';
import 'package:terappmobile/models/response/trains_station_response.dart';
import 'package:terappmobile/models/response/voyage_user.dart';
import 'package:terappmobile/provider/auth_provider.dart';

class AuthServices {
  /* ------------------- AuthService  -------------------*/
  static var client = http.Client(); /* login service */

  /* ------------------- check the phone   -------------------*/
  static Future<AuthMobileResponse?> checkPhoneNumber(
      AuthMobileRequest authMobileRequest) async {
    try {
      final response =
          await http.post(Uri.parse(Config.apiUrl + Config.authMobileApi),
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
                'Accept': '*/*'
              },
              body: jsonEncode(authMobileRequest));
      print("${response.body.toString()}");
      // Parse the response body and convert it to AuthMobileResponse
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final AuthMobileResponse authResponse =
          AuthMobileResponse.fromJson(jsonResponse);
      return authResponse;
    } catch (e) {
      throw Exception('fail the otp code:$e');
    }
  }

  /* --------------   validation otp code  -----------------*/
  static Future<AuthOtpResponse?> validationOtpService(
      AuthOtpRequest model) async {
    try {
      Map<String, String> requestHeaders = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      };
      var url = Uri.parse(Config.apiUrl + Config.authValidationCodeApi);
      var response = await client.post(url,
          headers: requestHeaders, body: jsonEncode(model));
      print('response otp code   ${response.body.toString()}');
      // if(response.statusCode == 400 || response.statusCode == 422 ){
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      AuthOtpResponse authOtpResponse = AuthOtpResponse.fromJson(jsonResponse);
      return authOtpResponse;

      // }
    } catch (e) {
      throw Exception('fail to log user :$e');
    }
  }

  /* --------------   register otp  -----------------*/
  static Future<AuthRegisterResponse?> registerService(
      AuthRegisterRequest model) async {
    try {
      Map<String, String> requestHeaders = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      };
      var url = Uri.parse(Config.apiUrl + Config.authRegisterApi);
      var response = await client.post(url,
          headers: requestHeaders, body: jsonEncode(model));
      if (response.statusCode == 201) {
        print('response register code   ${response.body.toString()}');
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        AuthRegisterResponse authRegisterResponse =
            AuthRegisterResponse.fromJson(jsonResponse);
        print("le resultat est ${authRegisterResponse.data}");
        return authRegisterResponse;
      } else {
        // Handle the case when the status code is not 201
        return null;
      }
    } catch (e) {
      throw Exception('fail to log user :$e');
    }
  }

  static Future<List<VoyageData>?> getUserByIdVoyageService(
      BuildContext context, int userId) async {
    // final app = Provider.of<AuthProvider>(context, listen: false);
    /* int userId = app.userId;

    if (userId == null) {
      throw Exception('User ID is not available');
    } */

    final url = Uri.parse('https://hackaton.falltechnology.com/api/v1/voyage/$userId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] != null) {
          final List voyageData = responseData['data'] as List;
          final List<VoyageData> voyages =
              voyageData.map((v) => VoyageData.fromJson(v)).toList();
          print("voyages $voyages");
          return voyages;
        } else {
          throw Exception('No data available');
        }
      } else {
        throw Exception(
            'Failed to load user voyage by id data: ${response.statusCode}');
      }
      /*  if (response.statusCode == 201) {
        print(
        'response get list voyage by iduser code   ${response.body.toString()}');
          final responseData = jsonDecode(response.body);
        final List voyageData = responseData as List;
        final List<VoyageData> voyages = voyageData
            .map((v) => VoyageData.fromJson(v))
            .toList();
        return voyages;
        
      } else {
        throw Exception('Failed to load user voyage by id data');
      } */
    } catch (e) {
      throw Exception('Failed to fetch user  voyage by id data: $e');
    }
  }
}
