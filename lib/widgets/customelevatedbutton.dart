import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double width;
  final double height;
  final Function()? onPressed;

  const CustomElevatedButton({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderRadius,
    required this.width,
    required this.height,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          tapTargetSize:
              MaterialTapTargetSize.shrinkWrap, // Remove click animation
          backgroundColor: backgroundColor,
          minimumSize: Size.fromHeight(height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',
          ),
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
