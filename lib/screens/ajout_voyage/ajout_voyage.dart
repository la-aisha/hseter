import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:terappmobile/models/choice_train.dart';
import 'package:terappmobile/screens/home/accueil.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/title_option.dart';
import 'package:terappmobile/widgets/customelevatedbutton.dart';

class AjoutVoyage extends StatefulWidget {
  const AjoutVoyage({Key? key}) : super(key: key);

  @override
  State<AjoutVoyage> createState() => _AjoutVoyageState();
}

class _AjoutVoyageState extends State<AjoutVoyage> {
  String scanneResultat = "";
  int selectedcarindex = 0;
  Type _selectedSegment = Type.secondeclasse;
  late int role; // Default role is entreprise

  List<ChoiceTrain> choiceTrains = [
    ChoiceTrain(id: 8355, depart: DateTime.now(), arrivee: DateTime.now()),
    ChoiceTrain(id: 8355, depart: DateTime.now(), arrivee: DateTime.now()),
    ChoiceTrain(id: 8355, depart: DateTime.now(), arrivee: DateTime.now()),
  ];
  final currentStep = 3;

  final appSteps = [
    'Configure',
    'Code',
    'Test',
    'Deploy',
    'Scale',
  ];
  
  String? _resultat;

  void displayAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            // You can adjust the size of the dialog by setting the height and width of the Container
            child: Container(
                width: 500, // Set the desired width
                height: 600,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Image.asset('images/ajoutvoyagesuccess.png', width: 250),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Color.fromRGBO(208, 213, 221, 1)),
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
                              TitleOption(
                                  data: "83511",
                                  color: AppColors.rouge,
                                  size: 20,
                                  weight: FontWeight.w600),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  /*  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            SuiviVoyage()))); */
                                },
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    //border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //padding: EdgeInsets.all(10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset('images/location3.png'),
                                        TitleOption(
                                            data: 'suivre',
                                            color: Colors.white,
                                            size: 15,
                                            weight: FontWeight.w600)
                                      ]),
                                ),
                              ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleOption(
                                        data: "Thiaroye",
                                        color: Color.fromRGBO(152, 162, 179, 1),
                                        size: 15,
                                        weight: FontWeight.w600),
                                    Spacer(),
                                    TitleOption(
                                        data: 'Thiaroye',
                                        color: Color.fromRGBO(152, 162, 179, 1),
                                        size: 15,
                                        weight: FontWeight.w600),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    TitleOption(
                                        data: '500 CFA',
                                        color: Colors.black,
                                        size: 16,
                                        weight: FontWeight.w600),
                                    Spacer(),
                                    TitleOption(
                                        data: '10 fev',
                                        color: Color.fromRGBO(152, 162, 179, 1),
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
                                  color: Color.fromRGBO(208, 213, 221, 1),
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
                                  color: Color.fromRGBO(152, 162, 179, 1),
                                  size: 18,
                                  weight: FontWeight.w600),
                              Spacer(),
                              Image.asset('images/classe.png'),
                              SizedBox(
                                width: 3,
                              ),
                              TitleOption(
                                  data: '1 zone',
                                  color: Color.fromRGBO(152, 162, 179, 1),
                                  size: 18,
                                  weight: FontWeight.w600),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                        width: MediaQuery.of(context).size.width / 2 - 60,
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
                          width: MediaQuery.of(context).size.width / 2 - 60,
                          height: 50,
                          onPressed: () {
                            scannCode();
                          }),
                    ],
                  )
                ])));
      },
    );
  }

  //alert message pour connection
  /* void displayAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Row(
            children: [
              Image.asset('images/ajoutvoyagesuccess.png' ,width: 300,),
             
            ],
          ),
          content: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color.fromRGBO(208, 213, 221, 1)),
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
                          TitleOption(
                              data: "83511",
                              color: AppColors.rouge,
                              size: 20,
                              weight: FontWeight.w600),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              /*  Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        SuiviVoyage()))); */
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                //border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //padding: EdgeInsets.all(10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('images/location3.png'),
                                    TitleOption(
                                        data: 'suivre',
                                        color: Colors.white,
                                        size: 15,
                                        weight: FontWeight.w600)
                                  ]),
                            ),
                          ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleOption(
                                    data: "Thiaroye",
                                    color: Color.fromRGBO(152, 162, 179, 1),
                                    size: 15,
                                    weight: FontWeight.w600),
                                Spacer(),
                                TitleOption(
                                    data: 'Thiaroye',
                                    color: Color.fromRGBO(152, 162, 179, 1),
                                    size: 15,
                                    weight: FontWeight.w600),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                TitleOption(
                                    data: '500 CFA',
                                    color: Colors.black,
                                    size: 16,
                                    weight: FontWeight.w600),
                                Spacer(),
                                TitleOption(
                                    data: '10 fev',
                                    color: Color.fromRGBO(152, 162, 179, 1),
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
                              color: Color.fromRGBO(208, 213, 221, 1),
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
                            backgroundColor: Color.fromRGBO(208, 213, 221, 1),
                            minRadius: 15,
                            child: Image.asset('images/star.png'),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          TitleOption(
                              data: '2nde classe',
                              color: Color.fromRGBO(152, 162, 179, 1),
                              size: 18,
                              weight: FontWeight.w600),
                          Spacer(),
                          Image.asset('images/classe.png'),
                          SizedBox(
                            width: 3,
                          ),
                          TitleOption(
                              data: '1 zone',
                              color: Color.fromRGBO(152, 162, 179, 1),
                              size: 18,
                              weight: FontWeight.w600),
                        ],
                      ),
                      SizedBox(
                        height: 30,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          /* actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ], */
        );
      },
    );
  }
 */
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    const kTileHeight = 50.0;
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
                          MaterialPageRoute(builder: ((context) => Accueil())));
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TitleOption(
                        data: 'Ajout de voyage',
                        color: Colors.white,
                        size: 23,
                        weight: FontWeight.normal,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: TitleOption(
                        data: 'Aligner le QR code dans le cadre à numériser',
                        color: AppColors.marron,
                        size: 20,
                        weight: FontWeight.w500,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                      ),
                    ),
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
                              displayAlert();
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void scannCode() async {
    String bareScannResult;
    try {
      bareScannResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "fermer", true, ScanMode.QR);
    } on PlatformException {
      bareScannResult = "echec de l'obtention de la version de la plateforme";
    }
    setState(() {
       _resultat = bareScannResult;
    });
  }
  
}

enum Type { secondeclasse, premierclasse }

Map<Type, Color> TypeColors = <Type, Color>{
  Type.secondeclasse: Colors.grey.shade300,
  Type.premierclasse: Colors.grey.shade300,
  //Type.cerulean: const Color(0xff007ba7),
};
