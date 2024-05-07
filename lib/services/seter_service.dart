import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:terappmobile/configs/config.dart';

import '../models/response/trains_station_response.dart';

class SeterService {
  /* ------------------- seter service  -------------------*/
  static var client = http.Client(); /* login service */


  /* -------------  get all trains service         ------------------- */

static Future<List<TrainStationsResponse>> getAllTrainStationService() async {
    try {
      String token = 'p19bkCMOjd4vWyDKI64joB0AyGbosKRZLHrklpdVctfu9WvIvLAVfwi0VRVv6yvf' ;
      final response = await http.get(
        Uri.parse(Config.apiUrlSeter + Config.allTrainsStation),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Accept': '*/*',
        'token': '$token',

        },
      );

      if (response.statusCode == 200) {
        // Successful GET request
        final responseData = jsonDecode(response.body);
        final List<dynamic> stationsData = responseData as List<dynamic>;
        final List<TrainStationsResponse> stations = stationsData
            .map((station) => TrainStationsResponse.fromJson(station))
            .toList();
        return stations;
      } else {
        throw Exception(
            'Failed to load train stations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load train stations: $e');
    }
  }
 }
