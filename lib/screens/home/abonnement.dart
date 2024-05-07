import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:terappmobile/models/choice_train.dart';
import 'package:terappmobile/screens/home/accueil.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/googlefonts.dart';
import 'package:terappmobile/utils/title_option.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:timelines/timelines.dart' as tl;

class Abonnement extends StatefulWidget {
  const Abonnement({Key? key}) : super(key: key);

  @override
  State<Abonnement> createState() => _AbonnementState();
}

class _AbonnementState extends State<Abonnement> {
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
                        data: 'SamaTer',
                        color: Colors.white,
                        size: 23,
                        weight: FontWeight.normal,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                      TitleOption(
                        data: 'Les abonnements',
                        color: Colors.white,
                        size: 16,
                        weight: FontWeight.w400,
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
                      child: CupertinoSlidingSegmentedControl<Type>(
                        backgroundColor: Colors.grey.shade100,
                        thumbColor: TypeColors[_selectedSegment]!,
                        groupValue: _selectedSegment,
                        onValueChanged: (Type? value) {
                          if (value != null) {
                            setState(() {
                              _selectedSegment = value;
                              print('selected seg ${value}');
                              if (value == Type.secondeclasse) {
                                role = 1;
                              } else {
                                role = 2;
                              }
                              // role = _selectedSegment == Type.fournisseur ? 1 : 2;
                            });
                          }
                        },
                        children: const <Type, Widget>{
                          Type.secondeclasse: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              '2nde classe',
                              style: TextStyle(
                                color: Color.fromRGBO(109, 76, 35, 1),
                              ),
                            ),
                          ),
                          Type.premierclasse: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              '1ere classe',
                              style: TextStyle(color: CupertinoColors.black),
                            ),
                          ),
                          Type.autres: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'autres',
                              style: TextStyle(color: CupertinoColors.black),
                            ),
                          ),
                        },
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TitleOption(
                      data: 'Ticket pour 1 voyage',
                      color: Colors.black,
                      size: 20,
                      weight: FontWeight.w500,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (_selectedSegment == Type.secondeclasse)
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 102,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.beige),
                                child: Image.asset('images/ticket.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromRGBO(245, 245, 245, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleOption(
                                          data: '1 zone',
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        TitleOption(
                                          data: '500F',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      /* mainAxisAlignment:
                                          MainAxisAlignment.spaceAround */
                                      children: [
                                        TitleOption(
                                          data: 'Dakar',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Thiaroye',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TitleOption(
                                          data: 'yeumbeul',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Bargny',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 102,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.beige),
                                child: Image.asset('images/ticket.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromRGBO(245, 245, 245, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleOption(
                                          data: '1 zone',
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        TitleOption(
                                          data: '500F',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      /* mainAxisAlignment:
                                          MainAxisAlignment.spaceAround */
                                      children: [
                                        TitleOption(
                                          data: 'Dakar',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Thiaroye',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TitleOption(
                                          data: 'yeumbeul',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Bargny',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 102,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.beige),
                                child: Image.asset('images/ticket.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromRGBO(245, 245, 245, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleOption(
                                          data: '1 zone',
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        TitleOption(
                                          data: '500F',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      /* mainAxisAlignment:
                                          MainAxisAlignment.spaceAround */
                                      children: [
                                        TitleOption(
                                          data: 'Dakar',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Thiaroye',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TitleOption(
                                          data: 'yeumbeul',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Bargny',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          ],
                      ),
                     if (_selectedSegment == Type.premierclasse)
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 102,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.beige),
                                child: Image.asset('images/ticket.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromRGBO(245, 245, 245, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleOption(
                                          data: '1 zone',
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        TitleOption(
                                          data: '500F',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      /* mainAxisAlignment:
                                          MainAxisAlignment.spaceAround */
                                      children: [
                                        TitleOption(
                                          data: 'Dakar',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Thiaroye',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TitleOption(
                                          data: 'yeumbeul',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Bargny',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 102,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.beige),
                                child: Image.asset('images/ticket.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromRGBO(245, 245, 245, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleOption(
                                          data: '1 zone',
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        TitleOption(
                                          data: '500F',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      /* mainAxisAlignment:
                                          MainAxisAlignment.spaceAround */
                                      children: [
                                        TitleOption(
                                          data: 'Dakar',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Thiaroye',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TitleOption(
                                          data: 'yeumbeul',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Bargny',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 102,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.beige),
                                child: Image.asset('images/ticket.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromRGBO(245, 245, 245, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleOption(
                                          data: '1 zone',
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        TitleOption(
                                          data: '500F',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      /* mainAxisAlignment:
                                          MainAxisAlignment.spaceAround */
                                      children: [
                                        TitleOption(
                                          data: 'Dakar',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Thiaroye',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TitleOption(
                                          data: 'yeumbeul',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Bargny',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 32,
                          ),
                         ],
                      ) ,
                   
                  if (_selectedSegment == Type.autres)
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 102,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.beige),
                                child: Image.asset('images/ticket.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromRGBO(245, 245, 245, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleOption(
                                          data: '1 zone',
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        TitleOption(
                                          data: '500F',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      /* mainAxisAlignment:
                                          MainAxisAlignment.spaceAround */
                                      children: [
                                        TitleOption(
                                          data: 'Dakar',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Thiaroye',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TitleOption(
                                          data: 'yeumbeul',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Bargny',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 102,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.beige),
                                child: Image.asset('images/ticket.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromRGBO(245, 245, 245, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleOption(
                                          data: '1 zone',
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        TitleOption(
                                          data: '500F',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      /* mainAxisAlignment:
                                          MainAxisAlignment.spaceAround */
                                      children: [
                                        TitleOption(
                                          data: 'Dakar',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Thiaroye',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TitleOption(
                                          data: 'yeumbeul',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Bargny',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 102,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.beige),
                                child: Image.asset('images/ticket.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromRGBO(245, 245, 245, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleOption(
                                          data: '1 zone',
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        TitleOption(
                                          data: '500F',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      /* mainAxisAlignment:
                                          MainAxisAlignment.spaceAround */
                                      children: [
                                        TitleOption(
                                          data: 'Dakar',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Thiaroye',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TitleOption(
                                          data: 'yeumbeul',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Image.asset('images/v.png'),
                                        TitleOption(
                                          data: 'Bargny',
                                          color: AppColors.marron,
                                          size: 20,
                                          weight: FontWeight.w500,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 32,
                          ),
                         ],
                      )
                 
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

enum Type { secondeclasse, premierclasse , autres }

Map<Type, Color> TypeColors = <Type, Color>{
  Type.secondeclasse: Colors.white,
  Type.premierclasse: Colors.white,
  Type.autres: Colors.white,

  //Type.cerulean: const Color(0xff007ba7),
};
