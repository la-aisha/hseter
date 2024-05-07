import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:terappmobile/provider/auth_provider.dart';
import 'package:terappmobile/screens/auth/info_perso.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/googlefonts.dart';
import 'package:terappmobile/utils/title_option.dart';

class Cgu extends StatefulWidget {
  @override
  _CguState createState() => _CguState();
}

class _CguState extends State<Cgu> {
  bool isChecked = false;

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
                      'images/logoter.png',
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
                    Container(
                      //color: Colors.blue,
                      //height: 300 ,
                      child: 
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'images/cgu.png',
                                width: 40,
                              ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TitleOption(data: 'Acceptez les conditions de la TER & Vérifier la confidentialité avis', color: Colors.black, size: 20, weight: FontWeight.bold ,maxLines: 3,),
                            ),
                          ],
                          ),
                          SizedBox(height: 30,),
                          RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                
                                text:
                                    'En sélectionnant "J\'accepte" ci-dessous, j\'ai lu et accepté les ',
                                style: TextStyle(color: Colors.black ,fontSize: 16),
                              ),
                              TextSpan(
                                text: 'conditions d\'utilisation',
                                style: TextStyle(color: Colors.red,fontSize: 16),
                              ),
                              TextSpan(
                                text: ' et ',
                                style: TextStyle(color: Colors.black,fontSize: 16),
                              ),
                              TextSpan(
                                text: 'avis de confidentialité',
                                style: TextStyle(color: Colors.red,fontSize: 16),
                              ),
                              TextSpan(
                                text: '. J\'ai au moins 18 ans.',
                                style: TextStyle(color: Colors.black,fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                          SizedBox(height: 10,) ,
                          Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          
                            //(height: 20),
                            Container(
                             // height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(245, 245, 245, 1),
                                borderRadius: BorderRadius.circular(5)
                              ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TitleOption(
                                    data: 'J’accepte',
                                    color: Colors.black,
                                    size: 18,
                                    weight: FontWeight.normal,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                        //final app = Provider.of<AuthProvider>(context, listen: false);
                                        //isChecked  = app.setCgu(value) ;

                                      });
                                    },
                                    shape: BeveledRectangleBorder(),
                                    activeColor: isChecked
                                        ? AppColors.marron
                                        : Colors.white,
                                  ),
                                ],
                              ),
                            
                            ),
                            SizedBox(height: 24,),
                          ]) 
                        
                        ]
                      ),
                    ),
                    Spacer() ,
                    //SizedBox(height: 20),
                    Expanded(
                     child : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                minimumSize: Size(width / 2 - 20, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                              onPressed:  isChecked ? () {
                                // Add your onPressed logic here
                              } : null ,
                              child: TitleText(
                                data: 'Decliner',
                                color: Colors.red,
                                size: 13,
                                weight: FontWeight.normal,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(width: 10,) ,
                          Flexible(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                tapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Remove click animation
                                backgroundColor: AppColors.marron,
                                minimumSize: Size(width / 2 - 20, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                              onPressed: isChecked ? () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> InfoPerso()));
                                                          
                              } : null,
                              child: TitleText(
                                data: 'Accepter',
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

                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
