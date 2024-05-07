import 'package:flutter/material.dart';
import 'package:terappmobile/models/response/trains_station_response.dart';
import 'package:terappmobile/services/seter_service.dart';

class SeterProvider extends ChangeNotifier {
 Future<List<TrainStationsResponse>> getALLtrainProvider(
      BuildContext context) async {
    try {
      final response = await SeterService.getAllTrainStationService();

      if (response.isNotEmpty) {
        return response;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erreur lors de la recharge des trains"),
            backgroundColor: Colors.red,
          ),
        );
        print('Erreur de vérification VALIDATION');
        throw Exception('Failed checking the stations');
      }
    } catch (e) {
      throw Exception('Failed checking station number: $e');
    }
  }
}
