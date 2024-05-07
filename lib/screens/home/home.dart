
import 'package:flutter/material.dart';
import 'package:terappmobile/models/nav_bar.dart';
import 'package:terappmobile/screens/home/abonnement.dart';
import 'package:terappmobile/screens/home/accueil.dart';
import 'package:terappmobile/screens/home/profile.dart';
import 'package:terappmobile/screens/home/ticket.dart';
import 'package:terappmobile/utils/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<NavBar> items = [];

  void barTapedd(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    items = [
      NavBar(
          label: "Accueil",
          imagePath: 'images/home1.png',
          selectedImagePath: 'images/home2.png',
          page: Accueil(),
          imageWidth: 30.0,
          imageHeight: 30),
      NavBar(
          label: "Tickets",
          imagePath: 'images/ticket1.png',
          selectedImagePath: 'images/ticket2.png',
          page: Ticket(),
          imageWidth: 30.0,
          imageHeight: 30),
      NavBar(
          label: "Abonnement",
          imagePath: 'images/card1.png',
          selectedImagePath: 'images/card2.png',
          page: Abonnement(),
          imageWidth: 30.0,),
      NavBar(
          label: "Profile",
          imagePath: 'images/user1.png',
          selectedImagePath: 'images/user2.png',
          page: Profile(),
          imageWidth: 30.0,
          imageHeight: 30),  
    ];
  }

  @override
  Widget build(BuildContext context) {
    //final ap = Provider.of<MyAuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    double width = size.width;
    var height = size.height;
    Color myColor1 = Color.fromRGBO(40, 0, 81, 1);
    Color myColor = Color.fromRGBO(40, 0, 81, 0.1);
    Color myColor2 = Color.fromRGBO(189, 22, 22, 1);

    final List<String> imgList = [
      'images/slider.png',
      'images/slider.png',
      'images/slider.png',
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: items.map((i) => i.item).toList(),
          onTap: barTapedd,
          iconSize: 10,
          selectedItemColor: AppColors.marron,
            unselectedItemColor:AppColors.marron,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500, fontFamily: 'Inter'),
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w300, fontFamily: 'Inter', color: Colors.deepPurple),
        ),
        body: items[currentIndex].page);
  }
}
