class TrainStationsResponse {
  
  int? id;
  String? nom;
  String? heureOuverture;
  String? heureFermeture;
  bool? placeParking;
  bool? parvis;
  bool? agence;
  List<Commerces>? commerces;
  bool? isSelected;

  TrainStationsResponse(
      {required this.id,
      required this.nom,
      required this.heureOuverture,
      required this.heureFermeture,
      required this.placeParking,
      required this.parvis,
      required this.agence,
      this.isSelected = false ,
      required this.commerces});

  factory TrainStationsResponse.fromJson(Map<String, dynamic> json) {
    return TrainStationsResponse(
      id: json['id'],
      nom: json['nom'],
      heureOuverture: json['heure_ouverture'],
      heureFermeture: json['heure_fermeture'],
      placeParking: json['place_parking'],
      parvis: json['parvis'],
      agence: json['agence'],
      commerces: json['commerces'] != null
          ? List<Commerces>.from((json['commerces'] as List<dynamic>)
              .map((x) => Commerces.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['heure_ouverture'] = this.heureOuverture;
    data['heure_fermeture'] = this.heureFermeture;
    data['place_parking'] = this.placeParking;
    data['parvis'] = this.parvis;
    data['agence'] = this.agence;
    if (this.commerces != null) {
      data['commerces'] = this.commerces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commerces {
  String nom;
  String description;

  Commerces({required this.nom, required this.description});

  factory Commerces.fromJson(Map<String, dynamic> json) {
    return Commerces(
      nom: json['nom'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['description'] = this.description;
    return data;
  }
}
