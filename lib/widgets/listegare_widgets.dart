import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terappmobile/models/response/trains_station_response.dart';
import 'package:terappmobile/provider/train_provider.dart';
import 'package:terappmobile/screens/train/gare_detail.dart';
import 'package:terappmobile/utils/app_colors.dart';

class ListeGareWidget extends StatelessWidget {
  final TrainStationsResponse trainStationsResponse;
  ListeGareWidget({super.key, required this.trainStationsResponse});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity - 20,
        height: 54,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Color.fromRGBO(242, 244, 247, 1),
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.rouge,
              child: Image.asset(
                'images/trainblanc.png',
                width: 20,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '${trainStationsResponse.nom!}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // Update the selected station using Provider
                Provider.of<GareProvider>(context, listen: false).agence ==
                    trainStationsResponse.agence;
                // Update the selected station using Provider
                Provider.of<GareProvider>(context, listen: false).parking ==
                    trainStationsResponse.placeParking;
                // Update the selected station using Provider
                Provider.of<GareProvider>(context, listen: false).parvis ==
                    trainStationsResponse.parvis;

                Provider.of<GareProvider>(context, listen: false)
                    .setSelectedStation(trainStationsResponse);
                // Navigate to details screen
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GareDetail()));
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                minRadius: 15,
                child: Image.asset(
                  'images/info.png',
                  height: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
