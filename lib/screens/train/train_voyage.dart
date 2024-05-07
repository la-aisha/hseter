import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terappmobile/models/response/trains_station_response.dart';
import 'package:terappmobile/provider/seter_provider.dart';
import 'package:terappmobile/provider/train_provider.dart';
import 'package:terappmobile/screens/home/home.dart';
import 'package:terappmobile/screens/train/gare_detail.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/title_option.dart';
import 'package:terappmobile/widgets/WrappedChoiceChipTrain.dart';

class TrainVoyage extends StatefulWidget {
  const TrainVoyage({Key? key}) : super(key: key);

  @override
  State<TrainVoyage> createState() => _TrainVoyageState();
}

class _TrainVoyageState extends State<TrainVoyage> {
  late Future<List<TrainStationsResponse>> gareFuture;
  String select = "";

  Future<List<TrainStationsResponse>> gares() async {
    final ap = Provider.of<SeterProvider>(context, listen: false);
    List<TrainStationsResponse> result = await ap.getALLtrainProvider(context);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gareFuture = gares();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    const kTileHeight = 50.0;
    bool _isDakarSelected = true; // Initially Dakar is selected

    //late LineStyle afterLineStyle = LineStyle();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            //color: Colors.amber,
          ),
          Container(
            height: 300,
            width: width,
            color: AppColors.marron,
          ),
          Positioned(
            top: 20,
            left: 10,
            right: 10,
            child: Container(
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: ((context) => Home())));
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.marron,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TitleOption(
                          data: 'Train de voyage',
                          color: Colors.white,
                          size: 23,
                          weight: FontWeight.normal,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                        TitleOption(
                          data: 'Trajet occasionnel',
                          color: Colors.white,
                          size: 16,
                          weight: FontWeight.w400,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 45),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 100,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: 300,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleOption(
                      data: 'Gares disponibles',
                      color: AppColors.marron,
                      size: 24,
                      weight: FontWeight.w500,
                      textAlign: TextAlign.left,
                    ),
                    TitleOption(
                      data: 'Sélectionnez une gare pour plus d’informations',
                      color: Color.fromRGBO(102, 112, 133, 1),
                      size: 14,
                      weight: FontWeight.w400,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 250, // Adjust the height as needed
                      child: Flexible(
                        child: FutureBuilder<List<TrainStationsResponse>>(
                          future: gareFuture,
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
                            } else {
                              List<TrainStationsResponse> choices =
                                  snapshot.data!;
                              TrainStationsResponse? selectedChoice =
                                  Provider.of<GareProvider>(context)
                                      .selectedStation;
                              print(
                                  '--------  GARE found before click CHOICECHIPS ${selectedChoice!.nom} --------');
                              /* setState(() {
                                select = removeGareDe(selectedChoice!.nom);
                              }); */

                              return WrappedChoiceChipStation(
                                choices:
                                    choices, // List of TrainStationsResponse choices
                                selectedChoice:
                                    selectedChoice, // Currently selected choice
                                onSelected: (TrainStationsResponse choice) {
                                  // Handle the selection of choice
                                  // This callback function will be called when a choice is selected
                                  // You can update the selectedChoice and perform any other necessary actions
                                  Provider.of<GareProvider>(context,
                                          listen: false)
                                      .setSelectedStation(choice);
                                  select = Provider.of<GareProvider>(context,
                                          listen: false)
                                      .selectedStation!
                                      .nom!;
                                },
                              );
                              /* WrappedChoiceChip(
                                choice: selectedChoice,
                                isSelected: selectedChoice,
                                onSelect: /* (TrainStationsResponse choice) {
                                  Provider.of<GareProvider>(context)
                                      .setSelectedStation(choice);
                                  selectedChoice =
                                      choice; // Update selectedChoice here
                                  print(
                                      '--------  GARE found after click FROM CHOICECHIPS ${selectedChoice!.nom} --------');
                                }, */
                              ); */
                            }
                          },
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    TitleOption(
                      data: 'Arrivée des prochains trains',
                      color: AppColors.marron,
                      size: 24,
                      weight: FontWeight.w500,
                      textAlign: TextAlign.right,
                    ),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(234, 236, 240, 1))),
                        //,color: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        height: 360,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      //radius: 90,
                                      backgroundColor:
                                          Color.fromRGBO(152, 162, 179, 1),
                                      child:
                                          Image.asset('images/location4.png'),
                                    ),
                                    TitleOption(
                                      data: (Provider.of<GareProvider>(context)
                                                      .selectedStation ==
                                                  null ||
                                              Provider.of<GareProvider>(context)
                                                      .selectedStation!
                                                      .nom ==
                                                  null)
                                          ? 'dakar'
                                          : removeGareDe(
                                              Provider.of<GareProvider>(context)
                                                  .selectedStation!
                                                  .nom!),

                                      // data: (Provider.of<GareProvider>(context).selectedStation!.nom! == Null ) ?  'dakar ' : removeGareDe(Provider.of<GareProvider>(context).selectedStation!.nom!),
                                      color: Color.fromRGBO(102, 112, 133, 1),
                                      size: 14,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                Image.asset('images/vd.png'),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      //radius: 90,
                                      backgroundColor:
                                          Color.fromRGBO(152, 162, 179, 1),
                                      child:
                                          Image.asset('images/location4.png'),
                                    ),
                                    TitleOption(
                                      data: "Diamniadio",
                                      color: Color.fromRGBO(102, 112, 133, 1),
                                      size: 14,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TitleOption(
                                  data: "Arrivé du prochain train",
                                  color: Color.fromRGBO(102, 112, 133, 1),
                                  size: 14,
                                  weight: FontWeight.w500,
                                ),
                                TitleOption(
                                  data: "7mn",
                                  color: AppColors.rouge,
                                  size: 14,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              height: 60,
                              width: double.infinity,
                              color: Color.fromRGBO(242, 244, 247, 1),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleOption(
                                        data: "Prochaine destination",
                                        color: Color.fromRGBO(102, 112, 133, 1),
                                        size: 14,
                                        weight: FontWeight.w500,
                                      ),
                                      TitleOption(
                                        data: "Durée du trajet",
                                        color: Color.fromRGBO(102, 112, 133, 1),
                                        size: 14,
                                        weight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleOption(
                                        data: "Yeumbeul",
                                        color: AppColors.marron,
                                        size: 19,
                                        weight: FontWeight.w500,
                                      ),
                                      TitleOption(
                                        data: "10mn",
                                        color: Color.fromRGBO(48, 183, 0, 1),
                                        size: 16,
                                        weight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      //radius: 90,
                                      backgroundColor:
                                          Color.fromRGBO(152, 162, 179, 1),
                                      child:
                                          Image.asset('images/location4.png'),
                                    ),
                                    TitleOption(
                                      data: "Dakar",
                                      color: Color.fromRGBO(102, 112, 133, 1),
                                      size: 14,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                Image.asset('images/vg.png'),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      //radius: 90,
                                      backgroundColor:
                                          Color.fromRGBO(152, 162, 179, 1),
                                      child:
                                          Image.asset('images/location4.png'),
                                    ),
                                    TitleOption(
                                      data: (Provider.of<GareProvider>(context)
                                                      .selectedStation ==
                                                  null ||
                                              Provider.of<GareProvider>(context)
                                                      .selectedStation!
                                                      .nom ==
                                                  null)
                                          ? 'Diamniadio'
                                          : removeGareDe(
                                              Provider.of<GareProvider>(context)
                                                  .selectedStation!
                                                  .nom!),

                                      /*  data: removeGareDe(Provider.of<GareProvider>(context)
                                      .selectedStation!.nom!), */
                                      color: Color.fromRGBO(102, 112, 133, 1),
                                      size: 14,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TitleOption(
                                  data: "Arrivé du prochain train",
                                  color: Color.fromRGBO(102, 112, 133, 1),
                                  size: 14,
                                  weight: FontWeight.w500,
                                ),
                                TitleOption(
                                  data: "-3mn",
                                  color: AppColors.rouge,
                                  size: 14,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              height: 60,
                              width: double.infinity,
                              color: Color.fromRGBO(242, 244, 247, 1),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleOption(
                                        data: "Prochaine destination",
                                        color: Color.fromRGBO(102, 112, 133, 1),
                                        size: 14,
                                        weight: FontWeight.w500,
                                      ),
                                      TitleOption(
                                        data: "Durée du trajet",
                                        color: Color.fromRGBO(102, 112, 133, 1),
                                        size: 14,
                                        weight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleOption(
                                        data: "Yeumbeul",
                                        color: AppColors.marron,
                                        size: 19,
                                        weight: FontWeight.w500,
                                      ),
                                      TitleOption(
                                        data: "10mn",
                                        color: Color.fromRGBO(48, 183, 0, 1),
                                        size: 16,
                                        weight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    GestureDetector(
                        onTap: () {
                          /*  Provider.of<GareProvider>(context, listen: false)
                              .setSelectedStation(trainStationsResponse);  */
                          // Navigate to details screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GareDetail()));
                        },
                        child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.marron,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/info.png',
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TitleOption(
                                    data: "Plus d’informations sur la gare",
                                    color: Colors.white,
                                    size: 16,
                                    weight: FontWeight.w500,
                                  ),
                                ])))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
