import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:terappmobile/models/page_model.dart';
import 'package:terappmobile/models/request/authotp_request.dart';
import 'package:terappmobile/provider/auth_provider.dart';
import 'package:terappmobile/screens/auth/cgu.dart';
import 'package:terappmobile/screens/auth/welcome.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/title_option.dart';
import 'package:terappmobile/utils/title_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart' as pc;
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  bool isactive = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  String? otpCode;

  void updateActiveState() {
    bool isActive = otpCode!.length == 6;
    setState(() {
      isactive = isActive;
    });
  }

  validationOtp() {
    final app = Provider.of<AuthProvider>(context, listen: false);
    var oldOtp = app.otp!;
    AuthOtpRequest authOtpRequest =
        AuthOtpRequest(oldOtp: oldOtp , newOtp: otpCode);
    print(' otp value $oldOtp , entered otp $otpCode');
    var result = app.validationOtpProvider(context, authOtpRequest);
  }

  @override
  initState() {
    super.initState();
    var app = Provider.of<AuthProvider>(context, listen: false);
    var phone = app.authMobileRequest!.phone;
    //var otp = app.authcoderesponse!.data.toString();
    var otp = app.authcoderesponse!.data!.otp;
    print('------  numer = $phone , otp = $otp  ----------');
    print(isactive);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    minRadius: 50,
                    backgroundColor: AppColors.beige,
                    child: Image.asset(
                      'images/messagephone.png',
                      height: 70,
                      width: 70,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TitleOption(
                    data:
                        'Veuillez entrer le code reçu par sms au +221 ${Provider.of<AuthProvider>(context, listen: false).authMobileRequest!.phone}',
                    color: Colors.black45,
                    size: 18,
                    weight: FontWeight.normal,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 30,
                        ),
                        child: Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.marron),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                              isactive = otpCode!.length == 6;
                            });
                            print(otpCode);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: isactive
                          ? () {
                              validationOtp();
                              /* Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => Cgu()))); */
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        //onSurface: AppColors.marron,
                        backgroundColor: AppColors.marron,
                        minimumSize: Size(double.infinity, 50),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Vérifier le code',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TitleText(
                        data: 'Temps restant 00s',
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        size: 14,
                        weight: FontWeight.normal,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        fontFamily: 'Inter',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: TitleText(
                          data: 'Renvoyer code',
                          color: AppColors.marron,
                          size: 14,
                          weight: FontWeight.bold,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          fontFamily: 'Inter',
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,) ,
                  Center(
                    child: Container(
                      color: AppColors.beige ,
                      child: Text(' le code otp ${Provider.of<AuthProvider>(context, listen: false).otp} '),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Text('HELLO')
        ],
      ),
    );
  }
}
