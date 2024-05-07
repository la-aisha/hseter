import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terappmobile/models/request/auth_code_request.dart';
import 'package:terappmobile/models/request/auth_register_request.dart';
import 'package:terappmobile/models/request/authotp_request.dart';
import 'package:terappmobile/models/response/auth_mobile_response.dart';
import 'package:terappmobile/models/response/auth_register_response.dart';
import 'package:terappmobile/provider/get_user_provider.dart';
import 'package:terappmobile/provider/update_user_infos_provider.dart';
import 'package:terappmobile/screens/auth/cgu.dart';
import 'package:terappmobile/screens/auth/otp.dart';
import 'package:terappmobile/screens/home/accueil.dart';
import 'package:terappmobile/screens/home/home.dart';
import 'package:terappmobile/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthMobileRequest? _authMobileRequest;
  AuthMobileResponse? _authMobileResponse;
  AuthRegisterResponse? _authRegisterResponse;

  AuthRegisterResponse? get authRegisterResponse => _authRegisterResponse;
  AuthMobileRequest? get authMobileRequest => _authMobileRequest;
  AuthMobileResponse? get authcoderesponse => _authMobileResponse;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  String? _fullname;
  String get fullname => _fullname!;

  int? _userId;
  int get userId => _userId!;

  String? _otp;
  String get otp => _otp!;

  late bool _cgu;
  bool get cgu => _cgu;
  setCgu(bool value) {
    _cgu = value;
    notifyListeners();
  }

  /* ------------------- Shared Preferences  -------------------*/

  /* check if user is signed in */
  void checksignin() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  /* save user to shared preferences */
  /* Future saveUserToSP(AuthRegisterResponse data) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    s.setString("user_model", jsonEncode(data));
    notifyListeners();
  }
 */
  Future saveUserToSP(dynamic userData) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    s.setString("user_model", jsonEncode(userData));
    notifyListeners();
  }

  /* get user to shared preferences */
  Future<dynamic> getUserFromSP() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String data = prefs.getString("user_model") ?? "";
      if (data.isNotEmpty) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        if (jsonData.containsKey('status')) {
          // Assuming 'status' field exists in AuthRegisterResponse
          AuthRegisterResponse userResponse =
              AuthRegisterResponse.fromJson(jsonData);
          print(
              'Retrieved AuthRegisterResponse from shared preferences: $userResponse');
          return userResponse;
        } else {
          AuthMobileResponse mobileResponse =
              AuthMobileResponse.fromJson(jsonData);
          print(
              'Retrieved AuthMobileResponse from shared preferences: $mobileResponse');
          return mobileResponse;
        }
      } else {
        print('No user data found in shared preferences');
        return null;
      }
    } catch (e) {
      print('Error retrieving user data from shared preferences: $e');
      return null;
    }
  }

  /* Future<AuthRegisterResponse?> getUserFromSP() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String data = prefs.getString("user_model") ?? "";
      if (data.isNotEmpty) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        AuthRegisterResponse? userResponse =
            AuthRegisterResponse.fromJson(jsonData);
        print('Retrieved user data from shared preferences: $userResponse');
        return userResponse;
      } else {
        print('No user data found in shared preferences');
        return null;
      }
    } catch (e) {
      print('Error retrieving user data from shared preferences: $e');
      return null;
    }
  }
 */
  /* Future<AuthRegisterResponse?> getUserFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString("user_model") ?? "";
    if (data.isNotEmpty) {
      Map<String, dynamic> jsonData = jsonDecode(data);
      return AuthRegisterResponse.fromJson(jsonData);
    }
    return null;
  } */

  /* -------------------     checkPhoneNumberProvider   -------------------*/
  Future<void> checkPhoneNumberProvider(
    AuthMobileRequest authMobileRequest,
    BuildContext context,
  ) async {
    final response = await AuthServices.checkPhoneNumber(authMobileRequest);
    try {
      _authMobileRequest = authMobileRequest;
      _authMobileResponse = response;
      _userId = response!.data!.id;

      if (response.status == 1) {
        print('user n exist pas');
        _otp = response!.data!.otp!;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Otp()),
        );
        notifyListeners();
      } else if (response?.status == 0) {
        //saveUserToSP(response);
        if (response != null &&
            response.data != null &&
            response.data is DataMobile) {
          _fullname = response.data!.fullname;
        }
        print('----- user exist -----');

        /* // Save user data to SharedPreferences
        if (response?.data != null) {
          saveUserToSP(response!.data);
        } */

        SharedPreferences prefs = await SharedPreferences.getInstance();
        // ignore: use_build_context_synchronously
        Provider.of<GetUserProvider>(context, listen: false).id =
            response!.data!.id!;
        // ignore: use_build_context_synchronously
        Provider.of<UpdateUserInfosProvider>(context, listen: false).id =
            response!.data!.id!;

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        notifyListeners();
      }
    } catch (e) {
      throw Exception('fail check phone number:$e');
    }
  }

/* -------------------    validation otp code    -------------------*/
  Future validationOtpProvider(
      BuildContext context, AuthOtpRequest authOtpRequest) async {
    try {
      final response = await AuthServices.validationOtpService(authOtpRequest);
      //String token = response!.token!;
      /* Provider.of<AuthProvider>(context, listen: false)
          .setToken(token); */ // Update token using TokenProvider
      //print('token value $token');

      if (response!.status != null && response.status == 0) {
        print(response.status);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Cgu()),
        );
        return response;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("le code saisit est invalide"),
            backgroundColor: Colors.red,
          ),
        );
        print('erreur de verification VALIDATION');
      }
    } catch (e) {
      throw Exception('fail checking the otp code number:$e');
    }
  }

  Future registerProvider(
      BuildContext context, AuthRegisterRequest authRegiserRequest) async {
    try {
      final response = await AuthServices.registerService(authRegiserRequest);

      if (response != null && response.status != null && response.status == 0) {
        _authRegisterResponse = response;
        _fullname = response.data!.fullname!;
        _userId = response!.data!.id;
        print(_userId);
        //saveUserToSP(response);
        //var username = await getUserFromSP().then((value) => null);
        print(response.status);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        return response;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erreur lors du register"),
            backgroundColor: Colors.red,
          ),
        );
        print('Erreur de vérification VALIDATION');
      }
    } catch (e) {
      throw Exception('Failed checking the register number: $e');
    }
  }

  Future getUserByIdVoyageProvider(BuildContext context, int user) async {
    try {
      final response =
          await AuthServices.getUserByIdVoyageService(context, user);
      if (response != null) {
        return response;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erreur lors du chargement "),
            backgroundColor: Colors.red,
          ),
        );
        print('Erreur de chargemeent voyage by user');
      }
    } catch (e) {
      throw Exception('Failed checking voyage by user: $e');
    }
  }
}
