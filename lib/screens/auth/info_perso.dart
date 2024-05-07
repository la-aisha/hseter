import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terappmobile/models/request/auth_register_request.dart';
import 'package:terappmobile/provider/auth_provider.dart';
import 'package:terappmobile/screens/home/accueil.dart';
import 'package:terappmobile/screens/home/home.dart';
import 'package:terappmobile/services/auth_service.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/googlefonts.dart';
import 'package:terappmobile/utils/title_option.dart';

class InfoPerso extends StatefulWidget {
  @override
  _InfoPersoState createState() => _InfoPersoState();
}

class _InfoPersoState extends State<InfoPerso> {
  bool isChecked = false;
  late TextEditingController nomController;
  late TextEditingController addressController;
  late TextEditingController carteController;

  bool isactive = false;
  bool switchValue = false;

  @override
  void initState() {
    // TODO: implement initState
    nomController = TextEditingController();
    addressController = TextEditingController();
    carteController = TextEditingController();

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

  void register() {
    final app = Provider.of<AuthProvider>(context, listen: false);
    var oldOtp = app.authcoderesponse!.data!.otp!;
    var phone = app.authMobileRequest!.phone!;
    AuthRegisterRequest authRegisterRequest = AuthRegisterRequest(
        fullname: nomController.text.trim(),
        otp: oldOtp,
        adress: addressController.text.trim(),
        phone: phone,
        cgu: true,
        isSubscribe: switchValue);
    app.registerProvider(context, authRegisterRequest);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              "images/terimage.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
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
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'images/logoter2.png',
                      width: 124,
                    ),
                  ),
                  SizedBox(width: 45),
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleOption(
                    data: 'Informations personnelles du profil',
                    color: AppColors.marron,
                    size: 32,
                    weight: FontWeight.w700,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TitleOption(
                    data: "Nom complet",
                    color: Color.fromRGBO(94, 94, 94, 1),
                    size: 16,
                    weight: FontWeight.w500,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: nomController,
                      onChanged: (value) {
                        updateActivateState();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Image.asset('images/person.png'),
                        hintText: 'Ex: John Doe',
                        //prefixText: "Ex: John Doe",
                        hintStyle: TextStyle(fontSize: 16),
                        labelStyle: TextStyle(color: Colors.black38),
                        fillColor: Color.fromRGBO(245, 245, 245, 1),
                        focusColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.grey.shade200),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TitleOption(
                    data: "Adresse de résidence",
                    color: Color.fromRGBO(94, 94, 94, 1),
                    size: 16,
                    weight: FontWeight.w500,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: addressController,
                      onChanged: (value) {
                        updateActivateState();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Image.asset('images/location.png'),
                        /* Icon(
                          Icons.location_city,
                          size: 25,
                          color: Colors.b,
                        ), */
                        suffixIcon: Image.asset('images/location2.png'),
                        hintText: 'Choisir l’adresse',
                        //prefixText: "Ex: John Doe",
                        hintStyle: TextStyle(fontSize: 16),
                        labelStyle: TextStyle(color: Colors.black38),
                        fillColor: Color.fromRGBO(245, 245, 245, 1),
                        focusColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.grey.shade200),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Abonné(e) carte ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        TextSpan(
                          text: 'SamaTER',
                          style: TextStyle(
                              color: AppColors.beige,
                              fontSize: 16,
                              fontFamily: "SFProDisplay",
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Indiquer si vous êtes abonné(e)',
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                            fontFamily: "SFProDisplay",
                            fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                          child: CupertinoSwitch(
                              value: switchValue,
                              activeColor: AppColors.beige,
                              onChanged: (bool value) {
                                setState(() {
                                  switchValue = value ?? false;
                                });

                                print(switchValue);
                              }))
                    ],
                  ),
                  (switchValue == true)
                      ? Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                              color: AppColors.beige,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Numéro de votre carte  ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      TextSpan(
                                        text: 'SamaTER',
                                        style: TextStyle(
                                            color: AppColors.beige,
                                            fontSize: 16,
                                            fontFamily: "SFProDisplay",
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 50,
                                  child: TextField(
                                    controller: carteController,
                                    onChanged: (value) {
                                      //updateActivateState();
                                    },
                                    decoration: InputDecoration(
                                      //prefixIcon: Image.asset('images/location.png'),
                                      /* Icon(
                                  Icons.location_city,
                                  size: 25,
                                  color: Colors.b,
                                ), */
                                      //suffixIcon: Image.asset('images/location2.png'),
                                      // hintText: 'Choisir l’adresse',
                                      //prefixText: "Ex: John Doe",
                                      hintStyle: TextStyle(fontSize: 16),
                                      labelStyle:
                                          TextStyle(color: Colors.black38),
                                      fillColor: Colors.white,
                                      //focusColor: Colors.grey,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                            width: 3.0, color: Colors.white),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 1,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Remove click animation
                      // onPrimary: Color.fromRGBO(245, 245, 245, 1),
                      backgroundColor: AppColors.marron,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    onPressed: isactive
                        ? () {
                            // Add your onPressed logic here

                            register();
                            /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Homescreencustomer())); */
                          }
                        : null,
                    child: TitleOption(
                      data: 'Enregistrer et continuer',
                      color: Colors.white,
                      size: 18,
                      weight: FontWeight.normal,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      // fontFamily: 'SFProDisplay',
                    ),
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
