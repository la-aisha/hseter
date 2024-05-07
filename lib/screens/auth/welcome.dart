import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terappmobile/screens/auth/sign_up.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/title_option.dart';
import 'package:terappmobile/utils/title_text.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Welcome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true, // or false based on your requirements

      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/welcome.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/logoter.png',
                        width: 256,
                        height: 100,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Dalal Ak Jam',
                        style: GoogleFonts.luckiestGuy(
                          //fontFamily: 'LuckiestGuy',
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TitleOption(
                        data:
                            "L'application TER, votre compagnon de voyage ultime! Explorez nos fonctionnalités pour simplifier votre trajet et enrichir votre expérience de voyage en train.",
                        color: Colors.white,
                        size: 15,
                        weight: FontWeight.normal,
                        maxLines: 4,
                        overflow: TextOverflow.clip,
                        fontFamily: 'SFProDisplay',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                tapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Remove click animation
                                // onPrimary: Color.fromRGBO(245, 245, 245, 1),
                                backgroundColor:
                                    Color.fromRGBO(245, 245, 245, 1),
                                minimumSize: Size(width / 2 - 30, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => SignUp())));
                                // Add your onPressed logic here
                              },
                              child: TitleText(
                                data: 'Se connecter',
                                color: AppColors.marron,
                                size: 13,
                                weight: FontWeight.normal,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                tapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Remove click animation
                                backgroundColor: AppColors.marron,
                                minimumSize: Size(width / 2 - 30, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => SignUp())));
                              },
                              child: TitleText(
                                data: 'S\' inscrire',
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
