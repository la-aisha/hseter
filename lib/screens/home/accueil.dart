import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terappmobile/models/card_info.dart';
import 'package:terappmobile/models/response/trains_station_response.dart';
import 'package:terappmobile/models/response/voyage_user.dart';
import 'package:terappmobile/models/voyage_info.dart';
import 'package:terappmobile/provider/auth_provider.dart';
import 'package:terappmobile/provider/seter_provider.dart';
import 'package:terappmobile/provider/train_provider.dart';
import 'package:terappmobile/screens/ajout_voyage/ajout_voyage.dart';
import 'package:terappmobile/screens/train/train_voyage.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/title_option.dart';
import 'package:terappmobile/widgets/customelevatedbutton.dart';
import 'package:terappmobile/widgets/listegare_widgets.dart';
import 'package:voice_message_package/voice_message_package.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  String userName = "";
  late Future<List<TrainStationsResponse>> gareFuture;
  late Future<List<VoyageData>> voyageFuture;

  Future<List<TrainStationsResponse>> gares() async {
    final ap = Provider.of<SeterProvider>(context, listen: false);
    List<TrainStationsResponse> result = await ap.getALLtrainProvider(context);
    return result;
  }

  Future<List<VoyageData>> voyagesByUser() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    var id = Provider.of<AuthProvider>(context, listen: false).userId;
    List<VoyageData> result = await ap.getUserByIdVoyageProvider(context, id);
    return result;
  }

  String removeGareDe(String stationName) {
    const prefix = 'Gare de ';
    if (stationName.startsWith(prefix)) {
      return stationName.substring(prefix.length).trim();
    } else {
      return stationName;
    }
  }

  List<Commerces>? commerces = [
    {
      "nom": "Relay",
      "description":
          "Relay, la plus grande marque internationale en Travel Essentials est présente à la gare de Dakar. Présents dans des centaines d’aéroports et de gares dans le monde, les magasins Relay sont un passage essentiel pour les voyageurs. Quel que soit le profil, Relay leur offre une sélection adaptée de produits essentiels au voyage qui facilitent et enrichissent leurs déplacements. Ouvert du lundi au dimanche de 8h00 à 20h00"
    },
    {
      "nom": "KEPAR KITCHEN",
      "description":
          "Un concept de restauration exclusif de rôtisserie de poulet (poulet grillé et poulet rôti) proposant des préparations à base d’ingrédients locaux. La spécificité de ce concept de restauration repose sur la production du poulet à la vue du consommateur. Ce nouveau concept à la gare de Dakar vous fera vivre des moments agréables et inoubliables.Votre restaurant le « Képar Kitchen » à la Gare de Dakar (TER) est ouvert de 07h00 à 21H00 du lundi au dimanche."
    },
    {
      "nom": "AELIA",
      "description":
          "AELIA Dakar propose une large gamme de parfums, cosmétiques maquillages, à prix attractifs ! Retrouvez les grandes marques de parfums dans la boutique AELIA à la gare de Dakar et venez vivre une expérience inoubliable. Ouvert de 8h00 à 20h00 du lundi au dimanche"
    }
  ].map((item) => Commerces.fromJson(item)).toList();

  List<CardInfo> cardInfoList = [];
  List<VoyageInfoResponse> voyageInfoList = [];

  void gareModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              //color: Colors.white,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.grey,
                        width: 100,
                        height: 3,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TitleOption(
                    data: 'Liste des gares du TER',
                    color: Colors.black,
                    size: 20,
                    weight: FontWeight.w600,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<TrainStationsResponse>>(
                    future: gares(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        List<TrainStationsResponse>? garesList = snapshot.data;
                        return ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final gare = garesList![index];
                            return InkWell(
                                onTap: () async {
                                  print(
                                      '--------  GARE PICKED ${snapshot.data![index].nom} --------');
                                  Provider.of<GareProvider>(context,
                                          listen: false)
                                      .setSelectedStation(
                                          snapshot.data![index]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TrainVoyage()),
                                  );
                                },
                                child: ListeGareWidget(
                                  trainStationsResponse: gare,
                                ));
                          },
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    var userid =
                        Provider.of<AuthProvider>(context, listen: false)
                            .userId!;
                    TrainStationsResponse trainStationsResponse =
                        TrainStationsResponse(
                            id: userid,
                            nom: removeGareDe('Gare de Dakar'),
                            heureOuverture: '05:00',
                            heureFermeture: '23:00',
                            placeParking: true,
                            parvis: true,
                            agence: true,
                            commerces: commerces);
                    Provider.of<GareProvider>(context, listen: false)
                        .setSelectedStation(trainStationsResponse);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrainVoyage()),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.marron,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TitleOption(
                            data: 'Voir plus de gares',
                            color: Colors.white,
                            size: 16,
                            weight: FontWeight.w400),
                        SizedBox(width: 5),
                        Image.asset('images/arrowgare.png'),
                      ],
                    ),
                  ),
                )
              ]),
            ));
  }

  void ajoutVoyageModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 4,
              width: double.infinity,
              //color: Colors.white,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.grey,
                        width: 100,
                        height: 3,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Image.asset('images/ajoutvoyage.png'),
                SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TitleOption(
                      data: 'Ajout d’un nouveau voyage',
                      color: Color.fromRGBO(20, 20, 20, 1),
                      size: 24,
                      weight: FontWeight.w400),
                ),
                TitleOption(
                    data:
                        'Scannez le code qr de votre ticket de voyage pour pouvoir l’enregistrer sur votre historique de voyage.',
                    color: Color.fromRGBO(102, 112, 133, 1),
                    size: 15,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    weight: FontWeight.w300),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomElevatedButton(
                      text: 'Annuler',
                      textColor: AppColors.marron,
                      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                      borderColor: Colors.white,
                      borderRadius: 6.0,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 50,
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Add your onPressed logic here
                      },
                    ),
                    CustomElevatedButton(
                        text: 'Scanner',
                        textColor: Colors.white,
                        backgroundColor: AppColors.marron,
                        borderColor: AppColors.marron,
                        borderRadius: 6.0,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AjoutVoyage()));
                        }),
                  ],
                ),

                /*  */
              ]),
            ));
  }

  /* Future<void> getUserFromSP() async {
    try {
      
       final value = await Provider.of<AuthProvider>(context, listen: false)
          .getUserFromSP();
      if (value != null) {
        print('Retrieved user data: $value');
        setState(() {
          if (value.data != null) {
            userName = value.data!.fullname!;
            print('---------- username = $userName -------------');
          } else {
            print('User data is null');
          }
        });
      } else {
        print('User data not found in shared preferences');
      } 
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  */
  @override
  void initState() {
    super.initState();
    //  fullname = Provider.of<AuthProvider>(context, listen: false)
    //     .authRegisterResponse!
    //     .data!
    //     .fullname!;

    //getUserFromSP();
    gareFuture = gares();
    voyageFuture = voyagesByUser();
    // fullname = Provider.of<AuthProvider>(context, listen: false).fullname;
    //print('----- user full name = ${fullname}');
    // File file = new File(audioFileUri.getPath());

    File audioFile2 = File('audios/audio.mp3');
    File audioFile1 = File('audios/audio.mp3');
    File audioFile3 = File('audios/audio.mp3');

    cardInfoList = [
      CardInfo(
        imageAsset: 'images/logoter.png',
        title: 'À savoir !',
        description:
            'Aliquam eget purus sit malesuada tempor euismod. Aliquam eget purus sit malesuada tempor euismod.',
        audioFile: audioFile1,
      ),
      CardInfo(
        imageAsset: 'images/logoter.png',
        title: 'À savoir !',
        description:
            'Aliquam eget purus sit malesuada tempor euismod. Aliquam eget purus sit malesuada tempor euismod.',
        audioFile: audioFile2,
      ),
      CardInfo(
        imageAsset: 'images/logoter.png',
        title: 'À savoir !',
        description:
            'Aliquam eget purus sit malesuada tempor euismod. Aliquam eget purus sit malesuada tempor euismod.',
        audioFile: audioFile3,
      ),
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.all(5),
        width: 180,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          //borderRadius: BorderRadius.circular(90)

          // borderRadius: BorderRadius.circular(200)
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Perform some action when the button is pressed
            print('Floating action button pressed!');
            ajoutVoyageModal();
          },
          backgroundColor: AppColors.marron,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                minRadius: 15,
                backgroundColor: Colors.white,
                child: Image.asset('images/plus.png'),
              ),
              TitleOption(
                  data: 'Ajouter voyage',
                  color: Colors.white,
                  size: 16,
                  weight: FontWeight.w600),

              /*  */
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: 300,
            width: double.infinity,
            child: Image.asset(
              "images/homefond.png",
              fit: BoxFit.fill,
              height: 230,
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleOption(
                              data:
                                  "Bonjour ${Provider.of<AuthProvider>(context, listen: false).fullname}",
                              color: Colors.white,
                              size: 18,
                              weight: FontWeight.w600),
                          TitleOption(
                              data: 'Où allez-vous aujourd’hui?',
                              color: Colors.white,
                              size: 16,
                              weight: FontWeight.w400)
                        ],
                      ),
                      CircleAvatar(
                        child: Image.asset('images/profile.png'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      gareModal();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Image.asset('images/arrow.png'),
                            SizedBox(
                              width: 15,
                            ),
                            TitleOption(
                                data: 'Point de départ',
                                color: Color.fromRGBO(152, 162, 179, 1),
                                size: 18,
                                weight: FontWeight.w500),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 150,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TitleOption(
                      data: 'Informations ',
                      color: AppColors.marron,
                      size: 25,
                      weight: FontWeight.w700,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 245, 245, 1),
                        borderRadius: BorderRadius.circular(6)),
                    height: 200,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ListView.builder(
                        reverse: true,
                        //padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: cardInfoList.length,
                        itemBuilder: (context, index) {
                          CardInfo cardInfo = cardInfoList[index];
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              width: 350,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 46,
                                          color:
                                              Color.fromRGBO(245, 245, 245, 1),
                                          child: Center(
                                            child: Image.asset(
                                              'images/logoter.png',
                                              width: 58,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //Image.asset(cardInfo.imageAsset),
                                              TitleOption(
                                                  data: cardInfo.title,
                                                  color: Colors.black,
                                                  size: 16,
                                                  weight: FontWeight.w500),
                                              TitleOption(
                                                  data: cardInfo.description,
                                                  color: Color.fromRGBO(
                                                      152, 162, 179, 1),
                                                  size: 12,
                                                  textAlign: TextAlign.start,
                                                  weight: FontWeight.w300),

                                              // Other card content
                                            ],
                                          ),
                                        )
                                      ],
                                    ),

                                    // color: Colors.red,
                                    /* child: Container(
                                            //height: 80,
                                           width: 280, */
                                    Flexible(
                                      child: VoiceMessageView(
                                        backgroundColor: Colors.white,
                                        circlesColor: AppColors.marron,
                                        activeSliderColor: AppColors.marron,
                                        notActiveSliderColor:
                                            Colors.transparent,
                                        size: 39,
                                        controller: VoiceController(
                                          audioSrc: cardInfo.audioFile!.path,
                                          maxDuration:
                                              const Duration(seconds: 10),
                                          isFile: false,
                                          onComplete: () {
                                            /// do something on complete
                                          },
                                          onPause: () {
                                            /// do something on pause
                                          },
                                          onPlaying: () {
                                            /// do something on playing
                                          },
                                          onError: (err) {
                                            /// do somethin on error
                                          },
                                        ),
                                        innerPadding: 12,
                                        cornerRadius: 5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TitleOption(
                      data: 'Historique des voyages',
                      color: Colors.black,
                      size: 20,
                      weight: FontWeight.w600),
                  Expanded(
                    child: FutureBuilder<List<VoyageData>>(
                      future:
                          voyageFuture, // Replace Future.value with your actual future
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          /// Display a message indicating that no trips have been made yet
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                //color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/imgpasdevoyage.png', // Replace with your image asset path
                                    width: 270.0, // Adjust image size as needed
                                    height: 129.0,
                                  ),
                                  SizedBox(height: 16.0),
                                  Container(
                                    width: 200,
                                    child: TitleOption(
                                      data:
                                          "Vous n’avez pas de voyage pour le moment",
                                      color: Color.fromRGBO(102, 112, 133, 1),
                                      size: 15,
                                      weight: FontWeight.w600,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          // Display a message indicating that no trips have been made yet
                        } else {
                          List<VoyageData> voyageInfoList = snapshot.data!;
                          return ListView.builder(
                            reverse: true,
                            //padding: EdgeInsets.all(10),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: voyageInfoList.length,
                            itemBuilder: (context, index) {
                              VoyageData voyageInfo = voyageInfoList[index];
                              return Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(208, 213, 221, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppColors.rouge,
                                              child: Image.asset(
                                                'images/trainblanc.png',
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 58,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'images/trajet.png',
                                                height: 49,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TitleOption(
                                                    data:
                                                        "${snapshot.data![index].depart}", // voyageInfoList[index].depart,
                                                    color: Color.fromRGBO(
                                                        152, 162, 179, 1),
                                                    size: 15,
                                                    weight: FontWeight.w600,
                                                  ),
                                                  Spacer(),
                                                  TitleOption(
                                                    data:
                                                        "${snapshot.data![index].destination}", //'/* ${voyageInfoList[index].arrive.toString()} */',
                                                    color: Color.fromRGBO(
                                                        152, 162, 179, 1),
                                                    size: 15,
                                                    weight: FontWeight.w600,
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                children: [
                                                  TitleOption(
                                                    data:
                                                        '${snapshot.data![index].prix} CFA',
                                                    color: Colors.black,
                                                    size: 16,
                                                    weight: FontWeight.w600,
                                                  ),
                                                  Spacer(),
                                                  TitleOption(
                                                    data:
                                                        '${snapshot.data![index].date}',
                                                    color: Color.fromRGBO(
                                                        152, 162, 179, 1),
                                                    size: 15,
                                                    weight: FontWeight.w600,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 10,
                                          decoration: BoxDecoration(
                                            //color: Colors.yellow,
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    208, 213, 221, 1),
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Color.fromRGBO(
                                                  208, 213, 221, 1),
                                              minRadius: 15,
                                              child: Image.asset(
                                                  'images/star.png'),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            TitleOption(
                                              data:
                                                  '${snapshot.data![index].classe}',
                                              color: Color.fromRGBO(
                                                  152, 162, 179, 1),
                                              size: 18,
                                              weight: FontWeight.w600,
                                            ),
                                            Spacer(),
                                            Image.asset('images/classe.png'),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            TitleOption(
                                              data:
                                                  '${snapshot.data![index].zone}',
                                              color: Color.fromRGBO(
                                                  152, 162, 179, 1),
                                              size: 18,
                                              weight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),

                    /*  ListView.builder(
                      reverse: true,
                      //padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: voyageInfoList.length,
                      itemBuilder: (context, index) {
                        VoyageInfoResponse voyageInfo = voyageInfoList[index];
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color.fromRGBO(208, 213, 221, 1)),
                                borderRadius: BorderRadius.circular(6)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColors.rouge,
                                        child: Image.asset('images/train.png'),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      /* TitleOption(
                                          data: voyageInfoList[index]
                                              .id
                                              .toString(),
                                          color: AppColors.rouge,
                                          size: 20,
                                          weight: FontWeight.w600), */
                                      Spacer(),
                                      /* GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      SuiviVoyage())));
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: AppColors.marron,
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          //padding: EdgeInsets.all(10),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'images/location3.png'),
                                                TitleOption(
                                                    data: 'suivre',
                                                    color: Colors.white,
                                                    size: 15,
                                                    weight: FontWeight.w600)
                                              ]),
                                        ),
                                      ), */
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 58,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'images/trajet.png',
                                          height: 49,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TitleOption(
                                                data:
                                                    "" /* voyageInfoList[index]
                                                    .depart */
                                                ,
                                                color: Color.fromRGBO(
                                                    152, 162, 179, 1),
                                                size: 15,
                                                weight: FontWeight.w600),
                                            Spacer(),
                                            TitleOption(
                                                data: "",
                                                //'/* ${voyageInfoList[index].arrive.toString()} */',
                                                color: Color.fromRGBO(
                                                    152, 162, 179, 1),
                                                size: 15,
                                                weight: FontWeight.w600),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            TitleOption(
                                                data:
                                                    '${voyageInfoList[index].prix.toString()} CFA',
                                                color: Colors.black,
                                                size: 16,
                                                weight: FontWeight.w600),
                                            Spacer(),
                                            TitleOption(
                                                data: '10 fev',
                                                color: Color.fromRGBO(
                                                    152, 162, 179, 1),
                                                size: 15,
                                                weight: FontWeight.w600),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                    decoration: BoxDecoration(
                                      //color: Colors.yellow,
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              Color.fromRGBO(208, 213, 221, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromRGBO(208, 213, 221, 1),
                                        minRadius: 15,
                                        child: Image.asset('images/star.png'),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      TitleOption(
                                          data: '2nde classe',
                                          color:
                                              Color.fromRGBO(152, 162, 179, 1),
                                          size: 18,
                                          weight: FontWeight.w600),
                                      Spacer(),
                                      Image.asset('images/classe.png'),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      TitleOption(
                                          data: '1 zone',
                                          color:
                                              Color.fromRGBO(152, 162, 179, 1),
                                          size: 18,
                                          weight: FontWeight.w600),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                   */
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
