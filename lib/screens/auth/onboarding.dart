import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terappmobile/models/page_model.dart';
import 'package:terappmobile/screens/auth/welcome.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/title_option.dart';
import 'package:terappmobile/utils/title_text.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<PageModel> pages = [
    PageModel(
      backgroundImage: 'images/ob1.png',
      title: 'Informations en temps réel',
      description:
          'Recevez des notifications pour rester informé à chaque étape de votre voyage et être au courant déventuels événements',
    ),
    PageModel(
      backgroundImage: 'images/ob2.png',
      title: 'Trajets occasionnels',
      description:
          'Explorez le plan de la ligne avec votre application, ainsi que les tarifs pour chaque zone. Profitez pleinement de nos tarifs avantageux.',
    ),
    PageModel(
      backgroundImage: 'images/ob3.png',
      title: 'Abonnement carte',
      description:
          'Désormais, au sein de votre application, vous avez la possibilité de recharger votre carte d’abonnement où que vous soyez.',
    ),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true, // or false based on your requirements

      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: height - height / 3 + 100,
            child: Image.asset(
              pages[currentIndex].backgroundImage,
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < pages.length; i++)
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        width: 20.0,
                        height: 3.0,
                        decoration: BoxDecoration(
                          color: i == currentIndex ? Colors.white : Colors.grey,
                        ),
                      ),
                  ],
                ),
                if (currentIndex != pages.length - 1)
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Passer',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                else
                  Text(''),
              ],
            ),
          ),
          Positioned.fill(
            top: height - height / 3,
            child: Container(
              //color: Colors.red,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: 300,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: TitleOption(
                            data: pages[currentIndex].title,
                            color: AppColors.marron,
                            size: 24,
                            weight: FontWeight.bold,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            fontFamily: 'SFProDisplay',
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        width: 2,
                      ),
                      (currentIndex == 2)
                          ? Align(
                              alignment: Alignment.center,
                              child: TitleOption(
                                data: 'SamaTER',
                                color: AppColors.beige,
                                size: 24,
                                weight: FontWeight.normal,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                fontFamily: 'SFProDisplay',
                                textAlign: TextAlign.center,
                                style: FontStyle.italic,
                              ))
                          : Text(''),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Align(
                      alignment: Alignment.center,
                      child: TitleText(
                        data: pages[currentIndex].description,
                        color: Colors.black,
                        size: 15,
                        weight: FontWeight.w500,
                        maxLines: 3,
                        overflow: TextOverflow.clip,
                        fontFamily: 'Poppins',
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (currentIndex != 0)
                        Flexible(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              tapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, // Remove click animation
                              //onPrimary: Color.fromRGBO(245, 245, 245, 1) ,
                              backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                              minimumSize: Size(width / 2 - 5, 50),
                              maximumSize: Size(width / 2 - 5, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                currentIndex--;
                              });
                            },
                            child: TitleText(
                                data: 'Precedent',
                                color: AppColors.marron,
                                size: 18,
                                weight: FontWeight.normal,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      Flexible(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.marron,
                            minimumSize: Size(
                              currentIndex == 0
                                  ? width * 3 / 4
                                  : width / 2 - 20,
                              50,
                            ),
                            maximumSize: Size(
                              currentIndex == 0
                                  ? width * 3 / 4
                                  : width / 2 - 20,
                              50,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          onPressed: () {
                            if (currentIndex < pages.length - 1) {
                              setState(() {
                                currentIndex++;
                              });
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Welcome()));
                            }
                          },
                          child: Text(
                              currentIndex == pages.length - 1
                                  ? 'Terminer'
                                  : 'Suivant',
                              style: GoogleFonts.getFont('Poppins',
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.clip,
                                  ))),
                        ),
                      ),
                    ],
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
