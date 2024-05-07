class VoyageUserResponse {
  final int status;
  final List<VoyageData> data;
  final String token;
  final String message;

  VoyageUserResponse({
    required this.status,
    required this.data,
    required this.token,
    required this.message,
  });

  factory VoyageUserResponse.fromJson(Map<String, dynamic> json) {
    return VoyageUserResponse(
      status: json['status'] as int,
      data: (json['data'] as List)
          .map((e) => VoyageData.fromJson(e as Map<String, dynamic>))
          .toList(),
      token: json['token'] as String,
      message: json['message'] as String,
    );
  }
}

class VoyageData {
  final int id;
  final String depart;
  final String destination;
  final String zone;
  final int prix;
  final String classe;
  final String date;
  final TrainId trainId;
  final UserId userId;

  VoyageData({
    required this.id,
    required this.depart,
    required this.destination,
    required this.zone,
    required this.prix,
    required this.classe,
    required this.date,
    required this.trainId,
    required this.userId,
  });

  factory VoyageData.fromJson(Map<String, dynamic> json) {
    return VoyageData(
      id: json['id'] as int,
      depart: json['depart'] as String,
      destination: json['destination'] as String,
      zone: json['zone'] as String,
      prix: json['prix'] as int,
      classe: json['classe'] as String,
      date: json['date'] as String,
      trainId: TrainId.fromJson(json['train_id'] as Map<String, dynamic>),
      userId: UserId.fromJson(json['user_id'] as Map<String, dynamic>),
    );
  }
}

class TrainId {
  final int id;
  final String title;
  final int number;

  TrainId({
    required this.id,
    required this.title,
    required this.number,
  });

  factory TrainId.fromJson(Map<String, dynamic> json) {
    return TrainId(
      id: json['id'] as int,
      title: json['title'] as String,
      number: json['number'] as int,
    );
  }
}

class UserId {
  final String fullname;
  final String adress;
  final String phone;
  final int cgu;
  final int isSubscribe;

  UserId({
    required this.fullname,
    required this.adress,
    required this.phone,
    required this.cgu,
    required this.isSubscribe,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      fullname: json['fullname'] as String,
      adress: json['adress'] as String,
      phone: json['phone'] as String,
      cgu: json['cgu'] as int,
      isSubscribe: json['isSubscribe'] as int,
    );
  }
}
