
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terappmobile/models/response/trains_station_response.dart';
import 'package:terappmobile/provider/train_provider.dart';
import 'package:terappmobile/utils/app_colors.dart';
import 'package:terappmobile/utils/title_option.dart';

class WrappedChoiceChipStation extends StatelessWidget {
  final List<TrainStationsResponse> choices;
  final TrainStationsResponse? selectedChoice;
  final ValueChanged<TrainStationsResponse>? onSelected;

  WrappedChoiceChipStation({
    required this.choices,
    required this.selectedChoice,
    required this.onSelected,
  });

  String removeGareDe(String? stationName) {
    if (stationName == null) return '';
    const prefix = 'Gare de ';
    if (stationName.startsWith(prefix)) {
      return stationName.substring(prefix.length).trim();
    } else {
      return stationName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: choices.map((choice) {
        final isSelected = selectedChoice == choice;
        return InkWell(
          onTap: () {
            Provider.of<GareProvider>(context, listen: false)
                .setSelectedStation(choice);
            if (onSelected != null) {
              onSelected!(choice);
            }
          },
          child: ChoiceChip(
            disabledColor: Color.fromRGBO(242, 244, 247, 1),
            showCheckmark: false,
            label: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  isSelected
                      ? 'images/picked.png'
                      : 'images/locationnotpicked.png',
                ),
                SizedBox(
                  width: 4,
                ),
                TitleOption(
                  data: removeGareDe(choice.nom),
                  color: isSelected
                      ? Colors.white
                      : Color.fromRGBO(102, 112, 133, 1),
                  size: 14,
                  weight: FontWeight.w500,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            selected: isSelected,
            selectedColor: isSelected ? AppColors.marron : Colors.white,
            onSelected: (_) {
              if (onSelected != null) {
                onSelected!(choice);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}

/* 
class WrappedChoiceChipStation extends StatelessWidget {
  final List<TrainStationsResponse> choices;
  final TrainStationsResponse? selectedChoice;
  final ValueChanged<TrainStationsResponse>? onSelected;

  WrappedChoiceChipStation({
    required this.choices,
    required this.selectedChoice,
    required this.onSelected,
  });

  
  String removeGareDe(String stationName) {
    const prefix = 'Gare de ';
    if (stationName.startsWith(prefix)) {
      return stationName.substring(prefix.length).trim();
    } else {
      return stationName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: choices.map((choice) {
        final isSelected = selectedChoice == choice;
        return InkWell(
          onTap: () {
            Provider.of<GareProvider>(context, listen: false)
                .setSelectedStation(choice);
            if (onSelected != null) {
              onSelected!(choice);
            }
          },
          child: ChoiceChip(
            disabledColor: Color.fromRGBO(242, 244, 247, 1),
           //side: BorderSide.none,
           //shape:  ,
            
            showCheckmark: false,
            label: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  isSelected
                      ? 'images/picked.png'
                      : 'images/locationnotpicked.png',
                ),
                SizedBox(width: 4,),
                TitleOption(
                  data: removeGareDe(choice!.nom!),
                  color: isSelected ? Colors.white : Color.fromRGBO(102, 112, 133, 1),
                  size: 14,
                  weight: FontWeight.w500,
                  textAlign: TextAlign.left,
                ),
                
              ],
            ),
            selected: isSelected,
            //backgroundColor: isSelected ? AppColors.marron : Colors.white,
            selectedColor: isSelected ? AppColors.marron : Colors.white,
            onSelected: (_) {
              if (onSelected != null) {
                onSelected!(choice);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}
 */