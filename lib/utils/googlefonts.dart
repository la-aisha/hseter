import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends Text {
  TitleText({
    required String data,
    required Color color,
    required double size,
    required FontWeight weight,
    required int? maxLines,
    required TextOverflow overflow,
    TextAlign? textAlign,
    FontStyle? style,
    required String fontFamily, // Use String for the font family
  }) : super(
    data,
    textAlign: textAlign,
    style: GoogleFonts.getFont(
      fontFamily,
      textStyle: TextStyle(
        color:color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        fontStyle: style,
      ),
    ),
    overflow: overflow,
    maxLines: maxLines,
  );
}
