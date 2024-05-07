import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terappmobile/models/request/auth_code_request.dart';
import 'package:terappmobile/provider/auth_provider.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/title_option.dart';
import 'package:terappmobile/utils/title_text.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController phoneNumberController = TextEditingController();
  bool isactive = false;

  void updateActiveState() {
    bool isActive = phoneNumberController.text.length == 9;
    setState(() {
      isactive = isActive;
    });
  }

  @override
  initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    phoneNumberController.addListener(updateActiveState);
    print(isactive);
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  void authPhone() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    AuthMobileRequest authMobileRequest =
        AuthMobileRequest(phone: phoneNumberController.text.toString());
    print('phone value ${phoneNumberController.text}');
    var result = ap.checkPhoneNumberProvider(authMobileRequest, context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
            child: Image.asset(
              "images/terimage.png",
              fit: BoxFit.fill,
              //width: width,
              height: 300,
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Container(
              width: width, // Adjust the width as needed
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
                          color: AppColors.marron,
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
                  SizedBox(width: 45), // Adjust the spacing as needed
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
                      topRight: Radius.circular(20))),
              height: 300,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      minRadius: 50,
                      backgroundColor: AppColors.beige,
                      child: Image.asset(
                        'images/phone.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    // Center(),

                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TitleOption(
                              data: 'Inscription',
                              color: AppColors.marron,
                              size: 32,
                              weight: FontWeight.bold,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                            TitleOption(
                              data: 'Renseigner votre numéro de téléphone',
                              color: Colors.black54,
                              size: 18,
                              weight: FontWeight.normal,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleOption(
                              data: 'Téléphone',
                              color: Colors.black45,
                              size: 16,
                              weight: FontWeight.w100,
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(245, 245, 245, 1),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'images/flag.png',
                                        width: 30,
                                        height: 20,
                                      ),
                                      TitleOption(
                                          data: '+221',
                                          color: Colors.black26,
                                          size: 16,
                                          weight: FontWeight.bold)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    //width: 250,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        //color: Color.fromRGBO(245, 245, 245, 1),
                                        /*  border: Border.all(
                                          color: AppColors.marron,
                                          width: 1,
                                        ), */
                                        borderRadius: BorderRadius.circular(6)),
                                    child: TextField(
                                      controller: phoneNumberController,
                                      onChanged: (value) {
                                        updateActiveState();
                                      },
                                      decoration: InputDecoration(
                                        hintText: '',
                                        labelStyle:
                                            TextStyle(color: Colors.black38),
                                        fillColor: Colors.white,
                                        focusColor: Colors.grey,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              width: 3.0,
                                              color: AppColors.marron),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // Remove click animation
                          backgroundColor: AppColors.marron,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        onPressed: isactive
                            ? () {
                                authPhone();
                                /*  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Otp())); */
                              }
                            : null,
                        child: TitleText(
                          data: 'Recevoir le OTP',
                          color: Colors.white,
                          size: 13,
                          weight: FontWeight.normal,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Text('HELLO')
        ],
      ),
    );
  }
}
