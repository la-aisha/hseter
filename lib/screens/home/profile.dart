import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terappmobile/provider/get_user_provider.dart';
import 'package:terappmobile/screens/home/carte_abonnement.dart';
import 'package:terappmobile/screens/home/home.dart';
import 'package:terappmobile/screens/home/modify_profile.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/title_option.dart';
import 'package:whatsapp_chatbot/whatsapp_chatbot.dart';

class Profile extends StatefulWidget {
  final List<String> keywords = [];

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    Provider.of<GetUserProvider>(context, listen: false).fetchUser();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("user_id") as int;
    print("l'id du user connecté $id");
  }

  @override
  Widget build(BuildContext context) {
    var getUser =
        Provider.of<GetUserProvider>(context, listen: false).getUserResponse;
    print("l'utilisateur est ${getUser['data']?['fullname']}");
    print("l'utilisateur est ${getUser['data']?['adress']!}");
    final config = Config(
      botDelay: 3,
      waitText: "entrain d'ecrire ...",
      defaultResponseMessage: "desolé! je ne vous comprend pas!",
      keywords: [
        'bonjour',
        'salut',
        "j'ai perdu mes bagages puisse les recupérées",
        "comment faire un abonnement ?",
        "comment recharger son abonnement ?",
        "abonnement",
      ],
      response: [
        'Bonjour 👋🏾\nComment puissons nous vous aidez ?',
        'Salut 👋🏾\nComment puissons nous vous aidez ?',
        'veuillez nous contacter par 33 920 00 40 ou nous ecrire via whatsapp',
        "Pour faire un abonnement, Se rendre dans l’une des agences commerciales du TER munit de sa pièce d’identitéCommuniquer les informations suivantes aux agents services voyageurs : âge, nom, prénom, numéro de téléphone, nom de la mère ainsi qu’une copie de la carte d’identité Se faire photographier.",
        "Pour recharger votre compte,il faut se rendre aux guichets et des distributeurs de Titre de transport. ou  A distance sur l’application TER et site web.",
        " Se rendre dans l’une des agences commerciales du TER munit de sa pièce d’identitéCommuniquer les informations suivantes aux agents services voyageurs : âge, nom, prénom, numéro de téléphone, nom de la mère ainsi qu’une copie de la carte d’identité Se faire photographier."
      ],
      greetings: "Bonjour 👋🏾\nComment puissons nous vous aidez?",
      headerText: 'TER voyage facile',
      subHeaderText: 'en ligne',
      buttonText: 'Aide et support',
      buttonColor: const Color.fromARGB(255, 73, 4, 4),
      chatIcon: const Icon(Icons.check),
      headerColor: const Color.fromARGB(255, 73, 4, 4),
      message: "Bonjour, j'ai besoin d'aide.",
      phoneNumber: '+221706979903',
      chatBackgroundColor: const Color.fromARGB(255, 238, 231, 223),
      onlineIndicator: const Color.fromARGB(255, 37, 211, 102),
    );
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
            height: 350,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Home()));
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
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'images/profil2.png',
                              height: 100,
                              width: 100,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleOption(
                                  data: '${getUser['data']?['fullname']}',
                                  color: AppColors.marron,
                                  size: 18,
                                  weight: FontWeight.w700,
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TitleOption(
                                  data: '${getUser['data']?['phone']}',
                                  color: Color.fromRGBO(152, 162, 179, 1),
                                  size: 16,
                                  weight: FontWeight.w500,
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ModifyProfile()));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(245, 245, 245, 1),
                                    ),
                                    child: Row(
                                      children: [
                                        TitleOption(
                                          data: 'Modifier profil',
                                          color: AppColors.marron,
                                          size: 16,
                                          weight: FontWeight.w600,
                                          maxLines: 1,
                                        ),
                                        Icon(
                                          Icons.arrow_right,
                                          color: AppColors.marron,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          width: width,
                          color: Color.fromRGBO(245, 245, 245, 1),
                          height: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('images/abonne.png'),
                              TitleOption(
                                data: 'Abonné',
                                color: Colors.black87,
                                size: 16,
                                weight: FontWeight.w600,
                                maxLines: 1,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              TitleOption(
                                data: 'SamaTER',
                                color: AppColors.beige,
                                size: 16,
                                weight: FontWeight.w600,
                                style: FontStyle.italic,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          //SizedBox(height: 300,) ,
          Positioned.fill(
            top: 270,
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleOption(
                          data: 'Carte ',
                          color: Colors.black87,
                          size: 20,
                          weight: FontWeight.w700,
                          maxLines: 2,
                        ),
                        TitleOption(
                          data: 'SamaTER ',
                          color: AppColors.marron,
                          size: 22,
                          weight: FontWeight.w700,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CarteAbonnement()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.rouge,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('images/logoter2.png'),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TitleOption(
                                  data: '${getUser['data']?['fullname']}',
                                  color: Colors.white,
                                  size: 22,
                                  weight: FontWeight.w700,
                                  maxLines: 2,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  height: 30,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: AppColors.beige,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: TitleOption(
                                    data: '123 456 789 ',
                                    color: Colors.white,
                                    size: 16,
                                    weight: FontWeight.w700,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              minRadius: 25,
                              child: Image.asset('images/arrowright.png'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Color.fromRGBO(220, 223, 227, 1),
                    width: double.infinity,
                    height: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 245, 245, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          minRadius: 40,
                          backgroundColor: AppColors.rouge,
                          child: Image.asset('images/aide.png'),
                        ),
                        // Image.asset('images/logoter2.png') ,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleOption(
                              data: 'Aide & support technique',
                              color: Colors.black,
                              size: 20,
                              weight: FontWeight.w700,
                              maxLines: 2,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TitleOption(
                                    data: '+221 33 123 45 67',
                                    color: Colors.grey,
                                    size: 20,
                                    weight: FontWeight.w700,
                                    maxLines: 1,
                                  ),
                                  Image.asset('images/aide2.png')
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Color.fromRGBO(220, 223, 227, 1),
                    width: double.infinity,
                    height: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 245, 245, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/exit.png'),
                        TitleOption(
                          data: 'Se déconnecter',
                          color: const Color(0xffE30024),
                          size: 20,
                          weight: FontWeight.w500,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),

                  //
                ],
              ),
            ),
          ),
          WhatsappChatBot(settings: config)
        ],
      ),
    );
  }
}
