import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:terappmobile/provider/get_user_provider.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/bottom_sheet.dart';
import 'package:terappmobile/utils/title_option.dart';
import 'package:terappmobile/widgets/customelevatedbutton.dart';

class CarteAbonnement extends StatefulWidget {
  @override
  _CarteAbonnementState createState() => _CarteAbonnementState();
}

class _CarteAbonnementState extends State<CarteAbonnement> {
  late TextEditingController addressController;
  late TextEditingController carteController;
  late TextEditingController nomController;
  late TextEditingController phoneNumberController = TextEditingController();

  bool isactive = false;
  bool switchValue = false;

  @override
  void initState() {
    // TODO: implement initState
    nomController = TextEditingController();
    addressController = TextEditingController();
    carteController = TextEditingController();
    Provider.of<GetUserProvider>(context, listen: false).fetchUser();

    nomController.addListener(updateActivateState);
    addressController.addListener(updateActivateState);
    carteController.addListener(updateActivateState);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nomController.dispose();
    addressController.dispose();
    carteController.dispose();
    super.dispose();
  }

  void updateActivateState() {
    bool isActive = false;

    if (!switchValue) {
      isActive =
          nomController.text.isNotEmpty && addressController.text.isNotEmpty;
    } else {
      isActive = carteController.text.isNotEmpty;
    }

    setState(() {
      isactive = isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var getUser =
        Provider.of<GetUserProvider>(context, listen: false).getUserResponse;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: 350,
            width: double.infinity,
            color: AppColors.rouge,
            /* child: Image.asset(
              "images/homefond.png",
              fit: BoxFit.fill,
              height: 230,
            ), */
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
                      Navigator.of(context).pop();
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
                        data: 'Carte SamaTER',
                        color: Colors.white,
                        size: 27,
                        weight: FontWeight.normal,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                      TitleOption(
                        data: 'Informations de mon abonnement',
                        color: Colors.white,
                        size: 16,
                        weight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ],
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
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      /* Positioned(
                        bottom: 100,
                        child: Container(
                          width: double.infinity,
                          height: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10) ,
                            color: AppColors.beige
                          ),
                        ),
                      ), */
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 230,
                        decoration: BoxDecoration(
                            color: AppColors.rouge,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'images/logoter2.png',
                                  height: 100,
                                  width: 100,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleOption(
                                      data: "${getUser['data']!['fullname']}"
                                          .split(" ")[0],
                                      color: Colors.white,
                                      size: 21,
                                      weight: FontWeight.w600,
                                      maxLines: 2,
                                    ),
                                    TitleOption(
                                      data: "${getUser['data']!['fullname']}"
                                          .split(" ")[1],
                                      color: Colors.white,
                                      size: 21,
                                      weight: FontWeight.w600,
                                      maxLines: 2,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              height: 95,
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: AppColors.beige,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  TitleOption(
                                    data: 'Numéro de ma carte SamaTER',
                                    color: Colors.white,
                                    size: 21,
                                    weight: FontWeight.w600,
                                    maxLines: 2,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TitleOption(
                                          data: '123 456 789 ',
                                          color: Colors.black,
                                          size: 21,
                                          weight: FontWeight.w600,
                                          maxLines: 2,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          width: 100,
                                          //height: 40,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  245, 245, 245, 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: TitleOption(
                                              data: 'Modifier',
                                              color: AppColors.marron,
                                              size: 14,
                                              weight: FontWeight.w600,
                                              maxLines: 2,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(245, 245, 245, 1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleOption(
                              data: 'Nomdre de zone d’accès',
                              color: Colors.black54,
                              size: 16,
                              weight: FontWeight.w600,
                              maxLines: 2,
                            ),
                            TitleOption(
                              data: '1 Zone',
                              color: Colors.black,
                              size: 16,
                              weight: FontWeight.w600,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleOption(
                              data: 'Classe',
                              color: Colors.black54,
                              size: 16,
                              weight: FontWeight.w600,
                              maxLines: 2,
                            ),
                            TitleOption(
                              data: '2nde Classe',
                              color: Colors.black,
                              size: 16,
                              weight: FontWeight.w600,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleOption(
                              data: 'Durée de validité',
                              color: Colors.black54,
                              size: 16,
                              weight: FontWeight.w600,
                              maxLines: 2,
                            ),
                            TitleOption(
                              data: '1 mois',
                              color: Colors.black,
                              size: 16,
                              weight: FontWeight.w600,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleOption(
                              data: 'Montant',
                              color: Colors.black54,
                              size: 16,
                              weight: FontWeight.w600,
                              maxLines: 2,
                            ),
                            TitleOption(
                              data: '15 000F',
                              color: Colors.black,
                              size: 16,
                              weight: FontWeight.w600,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, top: 15, bottom: 15),
                            height: 50,
                            width: 330,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              border: Border.all(width: 1),
                              color: Colors.white,
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.qr_code_scanner),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Voir le code QR ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset("images/qr.png"),
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(245, 245, 245, 1)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TitleOption(
                                data: 'Valable jusqu’au',
                                color: Colors.black54,
                                size: 16,
                                weight: FontWeight.w600,
                                maxLines: 2,
                              ),
                              TitleOption(
                                data: '10 Mars 2024',
                                color: Colors.black,
                                size: 16,
                                weight: FontWeight.w600,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          LinearPercentIndicator(
                            lineHeight: 10.0,
                            percent: 1,
                            animation: true,
                            width: 350,
                            progressColor: AppColors.beige,
                            backgroundColor: Colors.white,
                            barRadius: const Radius.circular(20),
                          ),
                          CustomElevatedButton(
                            text: 'renouveller mon abonnement',
                            textColor: Colors.white,
                            backgroundColor: AppColors.marron,
                            borderColor: AppColors.marron,
                            borderRadius: 10,
                            width: double.infinity,
                            height: 55,
                            onPressed: () {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (BuildContext context) {
                                  return const BottomSheetWidget();
                                },
                              );
                            },
                          )
                        ]),
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
