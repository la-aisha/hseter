/* class VoyageInfo {
  int id;
  String depart;
  String arrive;
  double prix;
  DateTime date;
  String classe;
  String zone;

  VoyageInfo({
    required this.id,
    required this.depart,
    required this.arrive,
    required this.prix,
    required this.date,
    required this.classe,
    required this.zone,
  });
}
 */
class VoyageInfoResponse {
  int  idUser;
  int codeProduit;
  String nomCommercial;
  String limitesDeValidit;
  String nombreDePRiodes;
  String typeDePRiode;
  int tempsDAntiPassbackSec;
  int tempsDeMultiValidationSec;
  int validitCourseSimpleMin;
  int voyagesTotaux;
  String dateDeBasculement;
  String supports;
  String profils;
  double prix;

  VoyageInfoResponse(
      {
      required this.idUser ,
      required this.codeProduit,
      required this.nomCommercial,
      required this.limitesDeValidit,
      required this.nombreDePRiodes,
      required this.typeDePRiode,
      required this.tempsDAntiPassbackSec,
      required this.tempsDeMultiValidationSec,
      required this.validitCourseSimpleMin,
      required this.voyagesTotaux,
      required this.dateDeBasculement,
      required this.supports,
      required this.profils,
      required this.prix});

  factory VoyageInfoResponse.fromJson(Map<String, dynamic> json) {
    return VoyageInfoResponse(
      idUser: json['idUser'],
      codeProduit: json['Code Produit'],
      nomCommercial: json['Nom Commercial'],
      limitesDeValidit: json['Limites de validité'],
      nombreDePRiodes: json['Nombre de périodes'],
      typeDePRiode: json['Type de période'],
      tempsDAntiPassbackSec: json['Temps d\'anti-passback (sec)'],
      tempsDeMultiValidationSec: json['Temps de multi-validation (sec)'],
      validitCourseSimpleMin: json['Validité course simple (min)'],
      voyagesTotaux: json['Voyages totaux'],
      dateDeBasculement: json['Date de basculement'],
      supports: json['Supports'],
      profils: json['Profils'],
      prix: json['Prix'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['Code Produit'] = this.codeProduit;
    data['Nom Commercial'] = this.nomCommercial;
    data['Limites de validité'] = this.limitesDeValidit;
    data['Nombre de périodes'] = this.nombreDePRiodes;
    data['Type de période'] = this.typeDePRiode;
    data['Temps d\'anti-passback (sec)'] = this.tempsDAntiPassbackSec;
    data['Temps de multi-validation (sec)'] = this.tempsDeMultiValidationSec;
    data['Validité course simple (min)'] = this.validitCourseSimpleMin;
    data['Voyages totaux'] = this.voyagesTotaux;
    data['Date de basculement'] = this.dateDeBasculement;
    data['Supports'] = this.supports;
    data['Profils'] = this.profils;
    data['Prix'] = this.prix;
    return data;
  }
}
