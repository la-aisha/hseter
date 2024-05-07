import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isSelected;

  Indicator({
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.0,
      height: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.blue : Colors.grey,
      ),
    );
  }
}
