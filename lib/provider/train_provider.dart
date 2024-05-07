/* import 'package:flutter/material.dart';
import 'package:terappmobile/models/response/trains_station_response.dart';

class GareProvider extends ChangeNotifier {
   TrainStationsResponse? _selectedStation;
   List<TrainStationsResponse> ?
      _trainStationsResponse; // Define trainStationsResponse here
   bool? _parking;
   bool? _parvis;
   bool? _agence;

  bool? get parking => _parking;
    bool? get parvis => _parvis;
      bool? get agence => _agence;



  GareProvider() {
    // Initialize trainStationsResponse here, you can fetch it from wherever it's coming from
    _trainStationsResponse = []; // Initialize with an empty list
  }

  List<TrainStationsResponse>? get trainStationsResponse =>
      _trainStationsResponse;

  TrainStationsResponse? get selectedStation => _selectedStation;

  void setSelectedStation(TrainStationsResponse station) {
    _selectedStation = station;
    notifyListeners();
  }
}
 */
import 'package:flutter/material.dart';
import 'package:terappmobile/models/response/trains_station_response.dart';

/* class GareProvider extends ChangeNotifier {
  TrainStationsResponse _selectedStation;
   List<TrainStationsResponse> _trainStationsResponse;
  late bool _parking;
  late bool _parvis;
  late bool _agence;

  bool get parking => _parking;
  bool get parvis => _parvis;
  bool get agence => _agence;

  GareProvider() {
    _trainStationsResponse = [];
    _parking = false; // Initialize _parking
    _parvis = false; // Initialize _parvis
    _agence = false; // Initialize _agence
  }

  List<TrainStationsResponse> get trainStationsResponse =>
      _trainStationsResponse;

  TrainStationsResponse get selectedStation => _selectedStation;

  void setSelectedStation(TrainStationsResponse station) {
    _selectedStation = station;
    notifyListeners();
  }
} */
class GareProvider extends ChangeNotifier {
  TrainStationsResponse? _selectedStation;
  List<TrainStationsResponse> _trainStationsResponse;
  bool _parking;
  bool _parvis;
  bool _agence;

  bool get parking => _parking;
  bool get parvis => _parvis;
  bool get agence => _agence;

  GareProvider()
      : _trainStationsResponse = [],
        _parking = true, // Initialize _parking
        _parvis = true, // Initialize _parvis
        _agence = true; // Initialize _agence

  List<TrainStationsResponse> get trainStationsResponse =>
      _trainStationsResponse;

  TrainStationsResponse? get selectedStation => _selectedStation;

  void setSelectedStation(TrainStationsResponse station) {
    _selectedStation = station;
    notifyListeners();
  }
}


